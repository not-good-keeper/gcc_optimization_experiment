	.file	"08_combined_program_2.c"
	.text
	.local	p
	.comm	p,3600000,32
	.local	q
	.comm	q,3600000,32
	.local	r
	.comm	r,3600000,32
	.section	.rodata
.LC0:
	.string	"%lld\n"
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
	subq	$32, %rsp
	movq	$0, -8(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L2
.L3:
	movl	-20(%rbp), %eax
	leal	(%rax,%rax), %ecx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	p(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -20(%rbp)
.L2:
	cmpl	$899999, -20(%rbp)
	jle	.L3
	movl	$0, -16(%rbp)
	jmp	.L4
.L5:
	movl	-16(%rbp), %eax
	leal	0(,%rax,8), %ecx
	movl	-16(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	q(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -16(%rbp)
.L4:
	cmpl	$899999, -16(%rbp)
	jle	.L5
	movl	$0, -12(%rbp)
	jmp	.L6
.L7:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	p(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	q(%rip), %rax
	movl	(%rcx,%rax), %eax
	leal	(%rdx,%rax), %ecx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	r(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	r(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	addq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L6:
	cmpl	$899999, -12(%rbp)
	jle	.L7
	movq	-8(%rbp), %rcx
	movabsq	$4835703278458516699, %rdx
	movq	%rcx, %rax
	imulq	%rdx
	sarq	$18, %rdx
	movq	%rcx, %rax
	sarq	$63, %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	imulq	$1000000, %rax, %rax
	subq	%rax, %rcx
	movq	%rcx, %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
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
