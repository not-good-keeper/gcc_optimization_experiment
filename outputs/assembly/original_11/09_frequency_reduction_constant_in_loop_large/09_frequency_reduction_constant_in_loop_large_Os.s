	.file	"09_frequency_reduction_constant_in_loop_large.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%lld\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	movq	$0, 8(%rsp)
.L2:
	movq	8(%rsp), %rdx
	addq	%rax, %rdx
	addq	$17, %rax
	movq	%rdx, 8(%rsp)
	cmpq	$85000000, %rax
	jne	.L2
	movq	8(%rsp), %rax
	movl	$1000000, %ecx
	movl	$1, %edi
	leaq	.LC0(%rip), %rsi
	cqto
	idivq	%rcx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
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
