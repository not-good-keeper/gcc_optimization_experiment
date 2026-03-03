	.file	"11_loop_fusion_large.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
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
	pxor	%xmm7, %xmm7
	movdqa	.LC2(%rip), %xmm3
	movdqa	.LC0(%rip), %xmm5
	movdqa	%xmm7, %xmm8
	leaq	a(%rip), %rdx
	movdqa	.LC1(%rip), %xmm4
	pcmpgtd	%xmm3, %xmm8
	movq	%rdx, %rax
	leaq	6000000(%rdx), %rcx
	movdqa	%xmm5, %xmm6
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm6, %xmm2
	movdqa	%xmm7, %xmm0
	paddd	%xmm4, %xmm6
	addq	$16, %rax
	movdqa	%xmm2, %xmm1
	movdqa	%xmm8, %xmm10
	punpckldq	%xmm2, %xmm1
	pcmpgtd	%xmm1, %xmm0
	pmuludq	%xmm1, %xmm10
	movdqa	%xmm0, %xmm9
	movdqa	%xmm1, %xmm0
	movdqa	%xmm2, %xmm1
	pmuludq	%xmm3, %xmm9
	pmuludq	%xmm3, %xmm0
	punpckhdq	%xmm2, %xmm1
	paddq	%xmm10, %xmm9
	movdqa	%xmm8, %xmm10
	psllq	$32, %xmm9
	pmuludq	%xmm1, %xmm10
	paddq	%xmm9, %xmm0
	movdqa	%xmm7, %xmm9
	pcmpgtd	%xmm1, %xmm9
	pmuludq	%xmm3, %xmm1
	pmuludq	%xmm3, %xmm9
	paddq	%xmm10, %xmm9
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm1
	shufps	$221, %xmm1, %xmm0
	psrad	$5, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$1, %xmm1
	paddd	%xmm0, %xmm1
	pslld	$3, %xmm1
	paddd	%xmm1, %xmm0
	pslld	$2, %xmm0
	psubd	%xmm0, %xmm2
	movaps	%xmm2, -16(%rax)
	cmpq	%rcx, %rax
	jne	.L2
	pxor	%xmm6, %xmm6
	leaq	b(%rip), %rcx
	movdqa	%xmm6, %xmm7
	movq	%rcx, %rax
	leaq	6000000(%rcx), %rsi
	pcmpgtd	%xmm3, %xmm7
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	%xmm5, %xmm0
	movdqa	%xmm7, %xmm9
	paddd	%xmm4, %xmm5
	addq	$16, %rax
	movdqa	%xmm0, %xmm2
	pslld	$1, %xmm2
	paddd	%xmm0, %xmm2
	movdqa	%xmm6, %xmm0
	movdqa	%xmm2, %xmm1
	punpckldq	%xmm2, %xmm1
	pcmpgtd	%xmm1, %xmm0
	pmuludq	%xmm1, %xmm9
	movdqa	%xmm0, %xmm8
	movdqa	%xmm1, %xmm0
	movdqa	%xmm2, %xmm1
	pmuludq	%xmm3, %xmm8
	pmuludq	%xmm3, %xmm0
	punpckhdq	%xmm2, %xmm1
	paddq	%xmm9, %xmm8
	movdqa	%xmm7, %xmm9
	psllq	$32, %xmm8
	pmuludq	%xmm1, %xmm9
	paddq	%xmm8, %xmm0
	movdqa	%xmm6, %xmm8
	pcmpgtd	%xmm1, %xmm8
	pmuludq	%xmm3, %xmm1
	pmuludq	%xmm3, %xmm8
	paddq	%xmm9, %xmm8
	psllq	$32, %xmm8
	paddq	%xmm8, %xmm1
	shufps	$221, %xmm1, %xmm0
	psrad	$5, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$1, %xmm1
	paddd	%xmm0, %xmm1
	pslld	$3, %xmm1
	paddd	%xmm1, %xmm0
	pslld	$2, %xmm0
	psubd	%xmm0, %xmm2
	movaps	%xmm2, -16(%rax)
	cmpq	%rax, %rsi
	jne	.L3
	xorl	%eax, %eax
	pxor	%xmm1, %xmm1
	pxor	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	(%rcx,%rax), %xmm0
	paddd	(%rdx,%rax), %xmm0
	movdqa	%xmm4, %xmm2
	addq	$16, %rax
	pcmpgtd	%xmm0, %xmm2
	movdqa	%xmm0, %xmm3
	punpckldq	%xmm2, %xmm3
	punpckhdq	%xmm2, %xmm0
	paddq	%xmm3, %xmm1
	paddq	%xmm0, %xmm1
	cmpq	$6000000, %rax
	jne	.L4
	movdqa	%xmm1, %xmm0
	leaq	.LC3(%rip), %rsi
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
	.local	b
	.comm	b,6000000,32
	.local	a
	.comm	a,6000000,32
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
	.align 16
.LC2:
	.long	1374389535
	.long	1374389535
	.long	1374389535
	.long	1374389535
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
