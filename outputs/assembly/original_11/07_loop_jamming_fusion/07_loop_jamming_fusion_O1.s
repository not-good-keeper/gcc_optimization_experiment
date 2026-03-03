	.file	"07_loop_jamming_fusion.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$1224, %rsp
	.cfi_def_cfa_offset 1232
	movq	%fs:40, %rax
	movq	%rax, 1208(%rsp)
	xorl	%eax, %eax
.L2:
	movl	%eax, (%rsp,%rax,4)
	addq	$1, %rax
	cmpq	$100, %rax
	jne	.L2
	leaq	400(%rsp), %rax
	leaq	800(%rsp), %rcx
	movl	$0, %edx
.L3:
	movl	%edx, (%rax)
	addl	$2, %edx
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.L3
	movl	$0, %eax
.L4:
	movl	400(%rsp,%rax), %edx
	addl	(%rsp,%rax), %edx
	movl	%edx, 800(%rsp,%rax)
	addq	$4, %rax
	cmpq	$400, %rax
	jne	.L4
	movl	1196(%rsp), %edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	1208(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L10
	movl	$0, %eax
	addq	$1224, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
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
