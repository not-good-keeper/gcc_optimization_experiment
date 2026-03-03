	.file	"07_loop_jamming_fusion.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1232, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -1228(%rbp)
	jmp	.L2
.L3:
	movl	-1228(%rbp), %eax
	cltq
	movl	-1228(%rbp), %edx
	movl	%edx, -1216(%rbp,%rax,4)
	addl	$1, -1228(%rbp)
.L2:
	cmpl	$99, -1228(%rbp)
	jle	.L3
	movl	$0, -1224(%rbp)
	jmp	.L4
.L5:
	movl	-1224(%rbp), %eax
	leal	(%rax,%rax), %edx
	movl	-1224(%rbp), %eax
	cltq
	movl	%edx, -816(%rbp,%rax,4)
	addl	$1, -1224(%rbp)
.L4:
	cmpl	$99, -1224(%rbp)
	jle	.L5
	movl	$0, -1220(%rbp)
	jmp	.L6
.L7:
	movl	-1220(%rbp), %eax
	cltq
	movl	-1216(%rbp,%rax,4), %edx
	movl	-1220(%rbp), %eax
	cltq
	movl	-816(%rbp,%rax,4), %eax
	addl	%eax, %edx
	movl	-1220(%rbp), %eax
	cltq
	movl	%edx, -416(%rbp,%rax,4)
	addl	$1, -1220(%rbp)
.L6:
	cmpl	$99, -1220(%rbp)
	jle	.L7
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
