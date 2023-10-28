#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define WINDOW_SIZE 8
#define MAX_FILE_NAME_LENGTH 100

// 判斷是否為 .sac 檔案
int is_sac_file(const char *file_path)
{
    const char *extension = ".sac";
    int path_length = strlen(file_path);
    int ext_length = strlen(extension);

    if (strcmp(file_path + path_length - ext_length, extension) == 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

// 取得高頻 byte 資訊
void get_most_common_byte_info(const unsigned char *window, unsigned char *most_common_byte, unsigned char *position, unsigned int *max_count)
{
    unsigned int count[256] = {0};

    // 計算數量
    for (int i = 0; i < WINDOW_SIZE; i++)
    {
        count[window[i]]++;
    }

    // 設定高頻的 byte 和數量
    *most_common_byte = 0x0;
    *max_count = 0;
    for (int i = 0; i < 256; i++)
    {
        if (count[i] > *max_count)
        {
            *max_count = count[i];
            *most_common_byte = (unsigned char)i;
        }
    }

    // 設定高頻 byte 的位置
    *position = 0x0;
    for (int i = 0; i < WINDOW_SIZE; i++)
    {
        if (window[i] == *most_common_byte)
        {
            *position |= (0x01 << WINDOW_SIZE - i - 1);
        }
    }
}

// 取得檔案內 byte 大小
unsigned long long get_file_total_byte(const char *file_path)
{
    FILE *file = fopen(file_path, "rb");
    if (!file)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }

    fseek(file, 0, SEEK_END);
    unsigned long long file_size = ftell(file);
    fclose(file);
    if (file_size == -1)
    {
        perror("[ERROR] failed to get file size");
        exit(1);
    }

    return file_size;
}

// 非高頻 byte 的 Node
struct Node
{
    int position;
    struct Node *next;
};

// 將該節點下所有 Node 動態記憶體清除
void freeList(struct Node *head)
{
    struct Node *tmp;

    while (head != NULL)
    {
        tmp = head;
        head = head->next;
        free(tmp);
    }
}

// 檔案路徑中取出檔名
char *extract_file_name(char *file_path)
{
    char *file_name = NULL;

    file_name = strrchr(file_path, '/');
    if (file_name == NULL)
    {
        file_name = strrchr(file_path, '\\');
    }

    if (file_name != NULL)
    {
        file_name++;
    }
    else
    {
        file_name = file_path;
    }

    return file_name;
}

// 壓縮
void compression(char *file_path)
{
    unsigned long long total_byte = 0;
    int ch = 0;
    int length = 8;
    unsigned char window[8] = {0x00};
    bool is_direct = false;
    unsigned char most_common_byte = 0x0;
    unsigned char position = 0x0;
    int max_count = 0;
    int index = 0;
    int remaining_byte = 0;

    // input file
    FILE *input_file = fopen(file_path, "rb");
    if (!input_file)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }

    // output file
    FILE *output_file = fopen("archive.sac", "wb");
    if (!output_file)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }

    // 寫入檔名資訊
    char *file_name = extract_file_name(file_path);
    unsigned char file_name_length = strlen(file_name);
    fwrite(&file_name_length, sizeof(unsigned char), 1, output_file);
    while (*file_name)
    {
        unsigned char ch = (unsigned char)*file_name;
        fwrite(&ch, sizeof(unsigned char), 1, output_file);
        file_name++;
    }

    //  0  1  2  3  4  5  6  7
    //  8  9 10 11 12 13 14 15
    // 16 17 18 19 20 21 22 23

    // 取得檔案內 byte 大小
    total_byte = get_file_total_byte(file_path);

    index = 0;
    is_direct = false;
    while ((ch = fgetc(input_file)) != EOF)
    {
        // printf("%02X ", ch);
        // 將 ch 依序存入 window 內
        window[index % 8] = (unsigned char)ch;
        if (is_direct == false)
        {
            // 每收集 WINDOW_SIZE 個處理一次
            if ((index + 1) % 8 == 0 && index != 0)
            {
                get_most_common_byte_info(window, &most_common_byte, &position, &max_count);

                // set first byte
                fwrite(&most_common_byte, sizeof(unsigned char), 1, output_file);
                // set second byte
                fwrite(&position, sizeof(unsigned char), 1, output_file);
                // set other byte
                for (int i = 0; i < WINDOW_SIZE; i++)
                {
                    if (window[i] != most_common_byte)
                    {
                        fwrite(&window[i], sizeof(unsigned char), 1, output_file);
                    }
                }

                // 判斷是否存在剩下的 byte 改成直接模式
                if (total_byte - (index + 1) < WINDOW_SIZE) // 23 - 15 < 8
                {
                    is_direct = true;
                }
            }
        }
        else
        {
            remaining_byte++;
            fwrite(&ch, sizeof(unsigned char), 1, output_file);
        }
        index++;
    }

    fwrite(&remaining_byte, sizeof(unsigned char), 1, output_file);

    fclose(input_file);
    fclose(output_file);
    printf("[STATUS] success");
}

// 解壓縮
void decompression(char *file_path)
{
    char file_name[MAX_FILE_NAME_LENGTH];
    unsigned char new_window[8] = {0x0};
    unsigned char most_common_byte;
    int stage = 1;
    int ch = 0;
    unsigned long long total_byte = 0;
    int first_byte = 0;
    int last_byte = 0;
    int index = 0;
    struct Node *headNode = (struct Node *)malloc(sizeof(struct Node));
    struct Node *currentNode = headNode;
    headNode->next = NULL;

    // input file
    FILE *input_file = fopen(file_path, "rb");
    if (!input_file)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }

    // 取得檔案內 byte 大小
    total_byte = get_file_total_byte(file_path);

    // 預先讀取檔案資訊 (副檔名資訊和最後一個 byte)
    FILE *temp_file;
    temp_file = fopen(file_path, "rb");
    if (temp_file == NULL)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }
    fseek(temp_file, 0, SEEK_SET);
    first_byte = fgetc(temp_file);

    for (int i = 0; i < first_byte; i++)
    {
        fseek(temp_file, i + 1, SEEK_SET);
        int file_name_ch = fgetc(temp_file);
        file_name[i] = (char)file_name_ch;
    }
    file_name[first_byte] = '\0';
    printf("[FILE NAME] %s\n", file_name);

    fseek(temp_file, -1, SEEK_END);
    last_byte = fgetc(temp_file);
    if (last_byte == EOF)
    {
        printf("[ERROR] error reading file");
        exit(1);
    }
    fclose(temp_file);

    // output file
    FILE *output_file = fopen(file_name, "wb");
    if (!output_file)
    {
        printf("[ERROR] %s can not open", file_path);
        exit(1);
    }

    index = 0;
    stage = 0;
    // printf("[CODE] ");
    while ((ch = fgetc(input_file)) != EOF)
    {
        // 移動到檔案內容第一個 byte
        if (stage == 0)
        {
            if (index < first_byte + 1)
            {
                index++;
                continue;
            }
            else
            {
                index = 0;
                stage = 1;
            }
        }

        // printf("%02X ", ch);
        if (index < total_byte - (first_byte + 1) - (last_byte + 1))
        {
            if (stage == 1)
            {
                currentNode = headNode;
                freeList(currentNode->next);
                currentNode->next = NULL;
                most_common_byte = (unsigned char)ch;
                stage = 2;
            }
            else if (stage == 2)
            {
                for (int i = 0; i < WINDOW_SIZE; i++)
                {
                    if ((((unsigned char)ch >> (WINDOW_SIZE - i - 1)) & 0x1) == 0x1)
                    {
                        new_window[i] = most_common_byte;
                    }
                    else
                    {
                        currentNode->next = (struct Node *)malloc(sizeof(struct Node));
                        currentNode = currentNode->next;
                        currentNode->position = i;
                        currentNode->next = NULL;
                    }
                }
                currentNode = headNode->next;
                if (currentNode != NULL)
                {
                    stage = 3;
                }
                else
                {
                    for (int i = 0; i < WINDOW_SIZE; i++)
                    {
                        fwrite(&new_window[i], sizeof(unsigned char), 1, output_file);
                    }
                    stage = 1;
                }
            }
            else
            {
                if (currentNode->next == NULL)
                {
                    new_window[currentNode->position] = (unsigned char)ch;
                    for (int i = 0; i < WINDOW_SIZE; i++)
                    {
                        fwrite(&new_window[i], sizeof(unsigned char), 1, output_file);
                    }
                    stage = 1;
                }
                else
                {
                    new_window[currentNode->position] = (unsigned char)ch;
                    currentNode = currentNode->next;
                }
            }
        }
        else
        {
            if (index != total_byte - (first_byte + 1) - 1)
            {
                fwrite(&ch, sizeof(unsigned char), 1, output_file);
            }
        }
        index++;
    }

    freeList(headNode);
    fclose(input_file);
    fclose(output_file);
    printf("[STATUS] success");
}

int main(int argc, char *argv[])
{
    printf("[FILE PATH] %s\n", argv[1]);
    if (is_sac_file(argv[1]))
    {
        printf("[MODE] decompression\n");
        decompression(argv[1]);
    }
    else
    {
        printf("[MODE] compression\n");
        compression(argv[1]);
    }
    return 0;
}