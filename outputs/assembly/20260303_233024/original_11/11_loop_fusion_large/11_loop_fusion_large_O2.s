	.file	"11_loop_fusion_large.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
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
	xorl	%edx, %edx
	leaq	a(%rip), %rcx
	.p2align 4,,10
	.p2align 3
.L2:
	movl	%edx, %eax
	movl	%edx, %edi
	imulq	$1374389535, %rax, %rax
	shrq	$37, %rax
	imull	$100, %eax, %eax
	subl	%eax, %edi
	movl	%edi, (%rcx,%rdx,4)
	addq	$1, %rdx
	cmpq	$1500000, %rdx
	jne	.L2
	leaq	b(%rip), %rdi
	xorl	%edx, %edx
	movq	%rdi, %rsi
	.p2align 4,,10
	.p2align 3
.L3:
	movl	%edx, %eax
	movl	%edx, %r8d
	addl	$3, %edx
	addq	$4, %rsi
	imulq	$1374389535, %rax, %rax
	shrq	$37, %rax
	imull	$100, %eax, %eax
	subl	%eax, %r8d
	movl	%r8d, -4(%rsi)
	cmpl	$4500000, %edx
	jne	.L3
	xorl	%edx, %edx
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rdi,%rdx), %eax
	addl	(%rcx,%rdx), %eax
	addq	$4, %rdx
	cltq
	addq	%rax, %rsi
	cmpq	$6000000, %rdx
	jne	.L4
	movq	%rsi, %rax
	movl	$1, %edi
	movabsq	$4835703278458516699, %rdx
	imulq	%rdx
	movq	%rsi, %rax
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	subq	%rax, %rsi
	xorl	%eax, %eax
	movq	%rsi, %rdx
	leaq	.LC0(%rip), %rsi
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
