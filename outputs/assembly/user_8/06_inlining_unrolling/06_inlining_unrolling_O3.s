	.file	"06_inlining_unrolling.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"%lld\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movdqa	.LC0(%rip), %xmm3
	movdqa	.LC1(%rip), %xmm6
	xorl	%eax, %eax
	movdqa	.LC2(%rip), %xmm5
	pxor	%xmm2, %xmm2
	pxor	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm3, %xmm0
	addl	$1, %eax
	paddd	%xmm6, %xmm3
	pand	%xmm5, %xmm0
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm0, %xmm1
	psrlq	$32, %xmm0
	pmuludq	%xmm0, %xmm0
	pshufd	$8, %xmm1, %xmm1
	pshufd	$8, %xmm0, %xmm0
	punpckldq	%xmm0, %xmm1
	movdqa	%xmm1, %xmm0
	movdqa	%xmm4, %xmm1
	pcmpgtd	%xmm0, %xmm1
	movdqa	%xmm0, %xmm7
	punpckldq	%xmm1, %xmm7
	punpckhdq	%xmm1, %xmm0
	paddq	%xmm7, %xmm2
	paddq	%xmm0, %xmm2
	cmpl	$250000, %eax
	jne	.L2
	movdqa	%xmm2, %xmm0
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movabsq	$4835703278458516699, %rdx
	psrldq	$8, %xmm0
	paddq	%xmm2, %xmm0
	movq	%xmm0, %rax
	movq	%xmm0, %rcx
	imulq	%rdx
	movq	%xmm0, %rax
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	subq	%rax, %rcx
	xorl	%eax, %eax
	movq	%rcx, %rdx
	call	__printf_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
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
	.long	255
	.long	255
	.long	255
	.long	255
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
