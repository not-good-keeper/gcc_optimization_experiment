	.file	"11_loop_fusion_large.c"
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
	leaq	a(%rip), %rsi
	movl	$100, %edi
	pushq	%rcx
	.cfi_def_cfa_offset 16
	xorl	%ecx, %ecx
	movq	%rsi, %r8
.L2:
	movl	%ecx, %eax
	cltd
	idivl	%edi
	movl	%edx, (%rsi,%rcx,4)
	incq	%rcx
	cmpq	$1500000, %rcx
	jne	.L2
	leaq	b(%rip), %rsi
	xorl	%ecx, %ecx
	movl	$100, %edi
	movq	%rsi, %r9
.L3:
	movl	%ecx, %eax
	addl	$3, %ecx
	addq	$4, %rsi
	cltd
	idivl	%edi
	movl	%edx, -4(%rsi)
	cmpl	$4500000, %ecx
	jne	.L3
	xorl	%edx, %edx
	xorl	%eax, %eax
.L4:
	movl	(%r9,%rdx), %ecx
	addl	(%r8,%rdx), %ecx
	addq	$4, %rdx
	movslq	%ecx, %rcx
	addq	%rcx, %rax
	cmpq	$6000000, %rdx
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
