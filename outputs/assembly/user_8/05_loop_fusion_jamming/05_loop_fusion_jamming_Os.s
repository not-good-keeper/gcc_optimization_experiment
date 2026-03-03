	.file	"05_loop_fusion_jamming.c"
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
	leaq	x(%rip), %rdx
	xorl	%eax, %eax
	movq	%rdx, %rsi
.L2:
	movl	%eax, %ecx
	andl	$127, %ecx
	movl	%ecx, (%rdx,%rax,4)
	incq	%rax
	cmpq	$1000000, %rax
	jne	.L2
	leaq	y(%rip), %rcx
	xorl	%eax, %eax
	movq	%rcx, %rdi
.L3:
	leal	(%rax,%rax), %edx
	andl	$126, %edx
	movl	%edx, (%rcx,%rax,4)
	incq	%rax
	cmpq	$1000000, %rax
	jne	.L3
	xorl	%edx, %edx
	xorl	%eax, %eax
.L4:
	movl	(%rdi,%rdx), %ecx
	addl	(%rsi,%rdx), %ecx
	addq	$4, %rdx
	movslq	%ecx, %rcx
	addq	%rcx, %rax
	cmpq	$4000000, %rdx
	jne	.L4
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
	.local	y
	.comm	y,4000000,32
	.local	x
	.comm	x,4000000,32
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
