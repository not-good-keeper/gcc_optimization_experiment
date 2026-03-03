	.file	"08_combined_program_2.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%lld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	p(%rip), %rax
	leaq	3600000(%rax), %rcx
	movl	$0, %edx
.L2:
	movl	%edx, (%rax)
	addl	$2, %edx
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.L2
	leaq	q(%rip), %rax
	leaq	3600000(%rax), %rcx
	movl	$0, %edx
.L3:
	movl	%edx, (%rax)
	addl	$8, %edx
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.L3
	movl	$0, %edx
	movl	$0, %ecx
	leaq	p(%rip), %rdi
	leaq	q(%rip), %rsi
.L4:
	movl	(%rsi,%rdx), %eax
	addl	(%rdi,%rdx), %eax
	cltq
	addq	%rax, %rcx
	addq	$4, %rdx
	cmpq	$3600000, %rdx
	jne	.L4
	movabsq	$4835703278458516699, %rdx
	movq	%rcx, %rax
	imulq	%rdx
	sarq	$18, %rdx
	movq	%rcx, %rax
	sarq	$63, %rax
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	subq	%rax, %rcx
	movq	%rcx, %rdx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.local	q
	.comm	q,3600000,32
	.local	p
	.comm	p,3600000,32
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
