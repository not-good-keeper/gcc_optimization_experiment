	.file	"07_loop_jamming_fusion.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	endbr64
	subq	$1224, %rsp
	.cfi_def_cfa_offset 1232
	movq	%fs:40, %rax
	movq	%rax, 1208(%rsp)
	xorl	%eax, %eax
	leaq	8(%rsp), %rcx
.L2:
	movl	%eax, (%rcx,%rax,4)
	incq	%rax
	cmpq	$100, %rax
	jne	.L2
	xorl	%eax, %eax
	leaq	408(%rsp), %rsi
.L3:
	leal	(%rax,%rax), %edx
	movl	%edx, (%rsi,%rax,4)
	incq	%rax
	cmpq	$100, %rax
	jne	.L3
	xorl	%eax, %eax
.L4:
	movl	(%rsi,%rax), %edx
	addl	(%rcx,%rax), %edx
	movl	%edx, 808(%rsp,%rax)
	addq	$4, %rax
	cmpq	$400, %rax
	jne	.L4
	movl	1204(%rsp), %edx
	xorl	%eax, %eax
	movl	$1, %edi
	leaq	.LC0(%rip), %rsi
	call	__printf_chk@PLT
	movq	1208(%rsp), %rax
	xorq	%fs:40, %rax
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	xorl	%eax, %eax
	addq	$1224, %rsp
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
