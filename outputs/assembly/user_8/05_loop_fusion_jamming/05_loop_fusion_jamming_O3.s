	.file	"05_loop_fusion_jamming.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
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
	leaq	x(%rip), %rdx
	movdqa	.LC1(%rip), %xmm3
	movdqa	.LC2(%rip), %xmm4
	movq	%rdx, %rax
	leaq	4000000(%rdx), %rcx
	movdqa	%xmm1, %xmm2
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm2, %xmm0
	addq	$16, %rax
	paddd	%xmm3, %xmm2
	pand	%xmm4, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rcx, %rax
	jne	.L2
	leaq	y(%rip), %rcx
	movdqa	.LC3(%rip), %xmm2
	movq	%rcx, %rax
	leaq	4000000(%rcx), %rsi
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	%xmm1, %xmm0
	addq	$16, %rax
	paddd	%xmm3, %xmm1
	pslld	$1, %xmm0
	pand	%xmm2, %xmm0
	movaps	%xmm0, -16(%rax)
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
	cmpq	$4000000, %rax
	jne	.L4
	movdqa	%xmm1, %xmm0
	leaq	.LC4(%rip), %rsi
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
	.local	y
	.comm	y,4000000,32
	.local	x
	.comm	x,4000000,32
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
	.long	127
	.long	127
	.long	127
	.long	127
	.align 16
.LC3:
	.long	126
	.long	126
	.long	126
	.long	126
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
