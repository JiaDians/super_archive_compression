# Makefile for compression.c

CC = gcc
CFLAGS = -Wall -Wextra -std=c99

SRC = compression.c
TARGET = compression

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

default: test

test: test1 test2

test1: $(TARGET)
	./$(TARGET) $(PWD)/data/TEST.txt

test2: $(TARGET)
	./$(TARGET) $(PWD)/archive.sac

clean:
	rm -f $(TARGET)

