	.file	"07_loop_jamming_fusion.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$1224, %rsp
	.cfi_def_cfa_offset 1232
	movdqa	.LC0(%rip), %xmm1
	movdqa	.LC1(%rip), %xmm2
	movq	%fs:40, %rax
	movq	%rax, 1208(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rsi
	leaq	400(%rsp), %rdx
	movq	%rsi, %rax
	movdqa	%xmm1, %xmm0
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm0, %xmm3
	addq	$16, %rax
	paddd	%xmm2, %xmm0
	movaps	%xmm3, -16(%rax)
	cmpq	%rax, %rdx
	jne	.L2
	movq	%rdx, %rax
	leaq	800(%rsp), %rcx
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	%xmm1, %xmm0
	addq	$16, %rax
	paddd	%xmm2, %xmm1
	pslld	$1, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rcx, %rax
	jne	.L3
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	(%rsi,%rax), %xmm0
	paddd	(%rdx,%rax), %xmm0
	movaps	%xmm0, (%rcx,%rax)
	addq	$16, %rax
	cmpq	$400, %rax
	jne	.L4
	movl	1196(%rsp), %edx
	xorl	%eax, %eax
	movl	$1, %edi
	leaq	.LC2(%rip), %rsi
	call	__printf_chk@PLT
	movq	1208(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L11
	xorl	%eax, %eax
	addq	$1224, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L11:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
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
