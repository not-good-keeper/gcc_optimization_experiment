	.file	"10_loop_unrolling_large_array.c"
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
	pushq	%rcx
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	leaq	arr(%rip), %rdx
.L2:
	movzbl	%al, %ecx
	movl	%ecx, (%rdx,%rax,4)
	incq	%rax
	cmpq	$2000000, %rax
	jne	.L2
	leaq	arr(%rip), %rdx
	xorl	%eax, %eax
	leaq	8000000(%rdx), %rcx
.L3:
	movslq	(%rdx), %rsi
	addq	$4, %rdx
	addq	%rsi, %rax
	cmpq	%rcx, %rdx
	jne	.L3
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
.LFE13:
	.size	main, .-main
	.local	arr
	.comm	arr,8000000,32
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
