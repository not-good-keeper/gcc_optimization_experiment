	.file	"06_inlining_unrolling.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
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
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L2:
	movzbl	%dl, %eax
	addl	$1, %edx
	imull	%eax, %eax
	cltq
	addq	%rax, %rcx
	cmpl	$1000000, %edx
	jne	.L2
	movq	%rcx, %rax
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movabsq	$4835703278458516699, %rdx
	mulq	%rdx
	shrq	$18, %rdx
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
