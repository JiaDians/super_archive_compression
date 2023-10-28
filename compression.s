	.file	"compression.c"
	.text
	.section .rdata,"dr"
LC0:
	.ascii ".sac\0"
	.text
	.globl	_is_sac_file
	.def	_is_sac_file;	.scl	2;	.type	32;	.endef
_is_sac_file:
LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$LC0, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -16(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -20(%ebp)
	movl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	subl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L2
	movl	$1, %eax
	jmp	L3
L2:
	movl	$0, %eax
L3:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE26:
	.globl	_get_most_common_byte_info
	.def	_get_most_common_byte_info;	.scl	2;	.type	32;	.endef
_get_most_common_byte_info:
LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%ebx
	subl	$1040, %esp
	.cfi_offset 7, -12
	.cfi_offset 3, -16
	leal	-1044(%ebp), %edx
	movl	$0, %eax
	movl	$256, %ecx
	movl	%edx, %edi
	rep stosl
	movl	$0, -12(%ebp)
	jmp	L5
L6:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	movl	-1044(%ebp,%eax,4), %edx
	addl	$1, %edx
	movl	%edx, -1044(%ebp,%eax,4)
	addl	$1, -12(%ebp)
L5:
	cmpl	$7, -12(%ebp)
	jle	L6
	movl	12(%ebp), %eax
	movb	$0, (%eax)
	movl	20(%ebp), %eax
	movl	$0, (%eax)
	movl	$0, -16(%ebp)
	jmp	L7
L9:
	movl	-16(%ebp), %eax
	movl	-1044(%ebp,%eax,4), %edx
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jbe	L8
	movl	-16(%ebp), %eax
	movl	-1044(%ebp,%eax,4), %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movb	%dl, (%eax)
L8:
	addl	$1, -16(%ebp)
L7:
	cmpl	$255, -16(%ebp)
	jle	L9
	movl	16(%ebp), %eax
	movb	$0, (%eax)
	movl	$0, -20(%ebp)
	jmp	L10
L12:
	movl	-20(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jne	L11
	movl	16(%ebp), %eax
	movzbl	(%eax), %eax
	movl	%eax, %ebx
	movl	$7, %eax
	subl	-20(%ebp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	orl	%ebx, %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
L11:
	addl	$1, -20(%ebp)
L10:
	cmpl	$7, -20(%ebp)
	jle	L12
	nop
	nop
	addl	$1040, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE27:
	.section .rdata,"dr"
LC1:
	.ascii "rb\0"
LC2:
	.ascii "[ERROR] %s can not open\0"
	.align 4
LC3:
	.ascii "[ERROR] failed to get file size\0"
	.text
	.globl	_get_file_total_byte
	.def	_get_file_total_byte;	.scl	2;	.type	32;	.endef
_get_file_total_byte:
LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	subl	$32, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	movl	$LC1, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L14
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L14:
	movl	$2, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_ftell
	cltd
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	-24(%ebp), %eax
	xorl	$-1, %eax
	movl	%eax, %esi
	movl	-20(%ebp), %eax
	xorl	$-1, %eax
	movl	%eax, %edi
	movl	%edi, %eax
	orl	%esi, %eax
	testl	%eax, %eax
	jne	L15
	movl	$LC3, (%esp)
	call	_perror
	movl	$1, (%esp)
	call	_exit
L15:
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	addl	$32, %esp
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE28:
	.globl	_freeList
	.def	_freeList;	.scl	2;	.type	32;	.endef
_freeList:
LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	jmp	L18
L19:
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 8(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	___mingw_free
	nop
L18:
	cmpl	$0, 8(%ebp)
	jne	L19
	nop
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE29:
	.globl	_extract_file_name
	.def	_extract_file_name;	.scl	2;	.type	32;	.endef
_extract_file_name:
LFB30:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$0, -12(%ebp)
	movl	$47, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strrchr
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L21
	movl	$92, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strrchr
	movl	%eax, -12(%ebp)
L21:
	cmpl	$0, -12(%ebp)
	je	L22
	addl	$1, -12(%ebp)
	jmp	L23
L22:
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
L23:
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE30:
	.section .rdata,"dr"
LC4:
	.ascii "wb\0"
LC5:
	.ascii "archive.sac\0"
LC6:
	.ascii "[STATUS] success\0"
	.text
	.globl	_compression
	.def	_compression;	.scl	2;	.type	32;	.endef
_compression:
LFB31:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$84, %esp
	.cfi_offset 3, -12
	movl	$0, -32(%ebp)
	movl	$0, -28(%ebp)
	movl	$0, -48(%ebp)
	movl	$8, -36(%ebp)
	movl	$0, -56(%ebp)
	movl	$0, -52(%ebp)
	movb	$0, -9(%ebp)
	movb	$0, -57(%ebp)
	movb	$0, -58(%ebp)
	movl	$0, -64(%ebp)
	movl	$0, -16(%ebp)
	movl	$0, -68(%ebp)
	movl	$LC1, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -40(%ebp)
	cmpl	$0, -40(%ebp)
	jne	L26
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L26:
	movl	$LC4, 4(%esp)
	movl	$LC5, (%esp)
	call	_fopen
	movl	%eax, -44(%ebp)
	cmpl	$0, -44(%ebp)
	jne	L27
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L27:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_extract_file_name
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movb	%al, -69(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-69(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	jmp	L28
L29:
	movl	-20(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, -70(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-70(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	addl	$1, -20(%ebp)
L28:
	movl	-20(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L29
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_get_file_total_byte
	movl	%eax, -32(%ebp)
	movl	%edx, -28(%ebp)
	movl	$0, -16(%ebp)
	movb	$0, -9(%ebp)
	jmp	L30
L36:
	movl	-48(%ebp), %ecx
	movl	-16(%ebp), %eax
	cltd
	shrl	$29, %edx
	addl	%edx, %eax
	andl	$7, %eax
	subl	%edx, %eax
	movl	%ecx, %edx
	movb	%dl, -56(%ebp,%eax)
	movzbl	-9(%ebp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	L31
	movl	-16(%ebp), %eax
	addl	$1, %eax
	andl	$7, %eax
	testl	%eax, %eax
	jne	L32
	cmpl	$0, -16(%ebp)
	je	L32
	leal	-64(%ebp), %eax
	movl	%eax, 12(%esp)
	leal	-58(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-57(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-56(%ebp), %eax
	movl	%eax, (%esp)
	call	_get_most_common_byte_info
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-57(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-58(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	movl	$0, -24(%ebp)
	jmp	L33
L35:
	leal	-56(%ebp), %edx
	movl	-24(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movzbl	-57(%ebp), %eax
	cmpb	%al, %dl
	je	L34
	leal	-56(%ebp), %edx
	movl	-24(%ebp), %eax
	addl	%eax, %edx
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	movl	%edx, (%esp)
	call	_fwrite
L34:
	addl	$1, -24(%ebp)
L33:
	cmpl	$7, -24(%ebp)
	jle	L35
	movl	-16(%ebp), %eax
	addl	$1, %eax
	cltd
	movl	-32(%ebp), %ecx
	movl	-28(%ebp), %ebx
	subl	%eax, %ecx
	sbbl	%edx, %ebx
	movl	%ecx, %eax
	movl	%ebx, %edx
	movl	$7, %ebx
	movl	$0, %ecx
	cmpl	%eax, %ebx
	sbbl	%edx, %ecx
	jc	L32
	movb	$1, -9(%ebp)
	jmp	L32
L31:
	movl	-68(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -68(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
L32:
	addl	$1, -16(%ebp)
L30:
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgetc
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	cmpl	$-1, %eax
	jne	L36
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$LC6, (%esp)
	call	_printf
	nop
	addl	$84, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE31:
	.section .rdata,"dr"
LC7:
	.ascii "[FILE NAME] %s\12\0"
LC8:
	.ascii "[ERROR] error reading file\0"
	.text
	.globl	_decompression
	.def	_decompression;	.scl	2;	.type	32;	.endef
_decompression:
LFB32:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$236, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	$0, -200(%ebp)
	movl	$0, -196(%ebp)
	movl	$1, -32(%ebp)
	movl	$0, -204(%ebp)
	movl	$0, -64(%ebp)
	movl	$0, -60(%ebp)
	movl	$0, -68(%ebp)
	movl	$0, -72(%ebp)
	movl	$0, -36(%ebp)
	movl	$8, (%esp)
	call	_malloc
	movl	%eax, -76(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-76(%ebp), %eax
	movl	$0, 4(%eax)
	movl	$LC1, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -80(%ebp)
	cmpl	$0, -80(%ebp)
	jne	L38
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L38:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_get_file_total_byte
	movl	%eax, -64(%ebp)
	movl	%edx, -60(%ebp)
	movl	$LC1, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -84(%ebp)
	cmpl	$0, -84(%ebp)
	jne	L39
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L39:
	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgetc
	movl	%eax, -68(%ebp)
	movl	$0, -44(%ebp)
	jmp	L40
L41:
	movl	-44(%ebp), %eax
	addl	$1, %eax
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgetc
	movl	%eax, -92(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, %ecx
	leal	-192(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	movb	%cl, (%eax)
	addl	$1, -44(%ebp)
L40:
	movl	-44(%ebp), %eax
	cmpl	-68(%ebp), %eax
	jl	L41
	leal	-192(%ebp), %edx
	movl	-68(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	leal	-192(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC7, (%esp)
	call	_printf
	movl	$2, 8(%esp)
	movl	$-1, 4(%esp)
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgetc
	movl	%eax, -72(%ebp)
	cmpl	$-1, -72(%ebp)
	jne	L42
	movl	$LC8, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L42:
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$LC4, 4(%esp)
	leal	-192(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -88(%ebp)
	cmpl	$0, -88(%ebp)
	jne	L43
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L43:
	movl	$0, -36(%ebp)
	movl	$0, -32(%ebp)
	jmp	L44
L61:
	cmpl	$0, -32(%ebp)
	jne	L45
	movl	-68(%ebp), %eax
	cmpl	-36(%ebp), %eax
	jl	L46
	addl	$1, -36(%ebp)
	jmp	L44
L46:
	movl	$0, -36(%ebp)
	movl	$1, -32(%ebp)
L45:
	movl	-36(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	-68(%ebp), %eax
	addl	$1, %eax
	cltd
	movl	-64(%ebp), %ecx
	movl	-60(%ebp), %ebx
	subl	%eax, %ecx
	sbbl	%edx, %ebx
	movl	-72(%ebp), %eax
	addl	$1, %eax
	cltd
	subl	%eax, %ecx
	sbbl	%edx, %ebx
	movl	%ecx, %eax
	movl	%ebx, %edx
	cmpl	%eax, %esi
	sbbl	%edx, %edi
	jnc	L47
	cmpl	$1, -32(%ebp)
	jne	L48
	movl	-76(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	_freeList
	movl	-40(%ebp), %eax
	movl	$0, 4(%eax)
	movl	-204(%ebp), %eax
	movb	%al, -25(%ebp)
	movl	$2, -32(%ebp)
	jmp	L49
L48:
	cmpl	$2, -32(%ebp)
	jne	L50
	movl	$0, -48(%ebp)
	jmp	L51
L54:
	movl	-204(%ebp), %eax
	movzbl	%al, %edx
	movl	$7, %eax
	subl	-48(%ebp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	L52
	leal	-200(%ebp), %edx
	movl	-48(%ebp), %eax
	addl	%eax, %edx
	movzbl	-25(%ebp), %eax
	movb	%al, (%edx)
	jmp	L53
L52:
	movl	$8, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-40(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	-48(%ebp), %edx
	movl	%edx, (%eax)
	movl	-40(%ebp), %eax
	movl	$0, 4(%eax)
L53:
	addl	$1, -48(%ebp)
L51:
	cmpl	$7, -48(%ebp)
	jle	L54
	movl	-76(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -40(%ebp)
	cmpl	$0, -40(%ebp)
	je	L55
	movl	$3, -32(%ebp)
	jmp	L49
L55:
	movl	$0, -52(%ebp)
	jmp	L56
L57:
	leal	-200(%ebp), %edx
	movl	-52(%ebp), %eax
	addl	%eax, %edx
	movl	-88(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	movl	%edx, (%esp)
	call	_fwrite
	addl	$1, -52(%ebp)
L56:
	cmpl	$7, -52(%ebp)
	jle	L57
	movl	$1, -32(%ebp)
	jmp	L49
L50:
	movl	-40(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L58
	movl	-204(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movb	%dl, -200(%ebp,%eax)
	movl	$0, -56(%ebp)
	jmp	L59
L60:
	leal	-200(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	%eax, %edx
	movl	-88(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	movl	%edx, (%esp)
	call	_fwrite
	addl	$1, -56(%ebp)
L59:
	cmpl	$7, -56(%ebp)
	jle	L60
	movl	$1, -32(%ebp)
	jmp	L49
L58:
	movl	-204(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movb	%dl, -200(%ebp,%eax)
	movl	-40(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -40(%ebp)
	jmp	L49
L47:
	movl	-36(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	-68(%ebp), %eax
	addl	$1, %eax
	cltd
	movl	-64(%ebp), %esi
	movl	-60(%ebp), %edi
	subl	%eax, %esi
	sbbl	%edx, %edi
	movl	%esi, %eax
	movl	%edi, %edx
	addl	$-1, %eax
	adcl	$-1, %edx
	movl	%ecx, %edi
	xorl	%eax, %edi
	movl	%edi, -224(%ebp)
	xorl	%edx, %ebx
	movl	%ebx, -220(%ebp)
	movl	-224(%ebp), %ebx
	movl	-220(%ebp), %esi
	movl	%esi, %eax
	orl	%ebx, %eax
	testl	%eax, %eax
	je	L49
	movl	-88(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$1, 4(%esp)
	leal	-204(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
L49:
	addl	$1, -36(%ebp)
L44:
	movl	-80(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgetc
	movl	%eax, -204(%ebp)
	movl	-204(%ebp), %eax
	cmpl	$-1, %eax
	jne	L61
	movl	-76(%ebp), %eax
	movl	%eax, (%esp)
	call	_freeList
	movl	-80(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$LC6, (%esp)
	call	_printf
	nop
	addl	$236, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE32:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC9:
	.ascii "[FILE PATH] %s\12\0"
LC10:
	.ascii "[MODE] decompression\0"
LC11:
	.ascii "[MODE] compression\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	call	___main
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC9, (%esp)
	call	_printf
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_is_sac_file
	testl	%eax, %eax
	je	L63
	movl	$LC10, (%esp)
	call	_puts
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_decompression
	jmp	L64
L63:
	movl	$LC11, (%esp)
	call	_puts
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_compression
L64:
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE33:
	.ident	"GCC: (MinGW.org GCC Build-2) 9.2.0"
	.def	_strlen;	.scl	2;	.type	32;	.endef
	.def	_strcmp;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_fseek;	.scl	2;	.type	32;	.endef
	.def	_ftell;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
	.def	_perror;	.scl	2;	.type	32;	.endef
	.def	___mingw_free;	.scl	2;	.type	32;	.endef
	.def	_strrchr;	.scl	2;	.type	32;	.endef
	.def	_fwrite;	.scl	2;	.type	32;	.endef
	.def	_fgetc;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
