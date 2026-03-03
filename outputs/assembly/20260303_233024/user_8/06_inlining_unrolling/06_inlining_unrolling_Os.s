	.file	"06_inlining_unrolling.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%lld\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rcx
	.cfi_def_cfa_offset 16
	xorl	%edx, %edx
	xorl	%eax, %eax
.L2:
	movzbl	%dl, %ecx
	incl	%edx
	imull	%ecx, %ecx
	movslq	%ecx, %rcx
	addq	%rcx, %rax
	cmpl	$1000000, %edx
	jne	.L2
	movl	$1000000, %ecx
	cqto
	movl	$1, %edi
	idivq	%rcx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	popq	%rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
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
