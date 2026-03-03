	.file	"08_combined_program_2.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%lld\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movdqa	.LC0(%rip), %xmm1
	leaq	p(%rip), %rdx
	movdqa	.LC1(%rip), %xmm3
	movq	%rdx, %rax
	leaq	3600000(%rdx), %rcx
	movdqa	%xmm1, %xmm2
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm2, %xmm0
	addq	$16, %rax
	paddd	%xmm3, %xmm2
	pslld	$1, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rax, %rcx
	jne	.L2
	leaq	q(%rip), %rcx
	movq	%rcx, %rax
	leaq	3600000(%rcx), %rsi
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	%xmm1, %xmm0
	addq	$16, %rax
	paddd	%xmm3, %xmm1
	pslld	$3, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rax, %rsi
	jne	.L3
	xorl	%eax, %eax
	pxor	%xmm1, %xmm1
	pxor	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	(%rdx,%rax), %xmm0
	paddd	(%rcx,%rax), %xmm0
	movdqa	%xmm4, %xmm2
	addq	$16, %rax
	pcmpgtd	%xmm0, %xmm2
	movdqa	%xmm0, %xmm3
	punpckldq	%xmm2, %xmm3
	punpckhdq	%xmm2, %xmm0
	paddq	%xmm3, %xmm1
	paddq	%xmm0, %xmm1
	cmpq	$3600000, %rax
	jne	.L4
	movdqa	%xmm1, %xmm0
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movabsq	$4835703278458516699, %rdx
	psrldq	$8, %xmm0
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	imulq	%rdx
	movq	%xmm0, %rax
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	movq	%xmm0, %rdx
	subq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.local	q
	.comm	q,3600000,32
	.local	p
	.comm	p,3600000,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC1:
	.long	4
	.long	4
	.long	4
	.long	4
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
