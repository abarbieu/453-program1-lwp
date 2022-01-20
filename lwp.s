	.file	"lwp.c"
	.globl	scheduler
	.bss
	.align 8
	.type	scheduler, @object
	.size	scheduler, 8
scheduler:
	.zero	8
	.comm	ptable,960,32
	.globl	procs
	.align 4
	.type	procs, @object
	.size	procs, 4
procs:
	.zero	4
	.globl	pid_counter
	.align 8
	.type	pid_counter, @object
	.size	pid_counter, 8
pid_counter:
	.zero	8
	.text
	.globl	round_robin
	.type	round_robin, @function
round_robin:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	round_robin, .-round_robin
	.globl	new_lwp
	.type	new_lwp, @function
new_lwp:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movl	procs(%rip), %eax
	cmpl	$30, %eax
	jne	.L4
	movl	$-1, %eax
	jmp	.L5
.L4:
	movl	procs(%rip), %edx
	movq	pid_counter(%rip), %rax
	addq	$1, %rax
	movq	%rax, pid_counter(%rip)
	movq	pid_counter(%rip), %rax
	movslq	%edx, %rdx
	salq	$5, %rdx
	addq	$ptable, %rdx
	movq	%rax, (%rdx)
	movl	procs(%rip), %ebx
	movq	-56(%rbp), %rax
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc
	movslq	%ebx, %rdx
	salq	$5, %rdx
	addq	$ptable, %rdx
	movq	%rax, 8(%rdx)
	movl	procs(%rip), %eax
	cltq
	salq	$5, %rax
	leaq	ptable+16(%rax), %rdx
	movq	-56(%rbp), %rax
	movq	%rax, (%rdx)
	movl	procs(%rip), %eax
	cltq
	salq	$5, %rax
	addq	$ptable, %rax
	movq	8(%rax), %rax
	movq	-56(%rbp), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	subq	$8, -24(%rbp)
	movq	-48(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	subq	$8, -24(%rbp)
	movl	$lwp_exit, %edx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	subq	$8, -24(%rbp)
	movq	-40(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$2882400001, %ecx
	movq	%rcx, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$2863311530, %esi
	movq	%rsi, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$3149642683, %ecx
	movq	%rcx, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$3435973836, %edi
	movq	%rdi, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$3722304989, %ebx
	movq	%rbx, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$4008636142, %esi
	movq	%rsi, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$4294967295, %ecx
	movq	%rcx, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	subq	$8, -24(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	movl	procs(%rip), %eax
	cltq
	salq	$5, %rax
	leaq	ptable+16(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 8(%rdx)
	movl	procs(%rip), %eax
	addl	$1, %eax
	movl	%eax, procs(%rip)
	movl	procs(%rip), %eax
	cltq
	salq	$5, %rax
	addq	$ptable, %rax
	movq	(%rax), %rax
.L5:
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	new_lwp, .-new_lwp
	.globl	lwp_exit
	.type	lwp_exit, @function
lwp_exit:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	lwp_exit, .-lwp_exit
	.globl	lwp_getpid
	.type	lwp_getpid, @function
lwp_getpid:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	lwp_getpid, .-lwp_getpid
	.globl	lwp_yield
	.type	lwp_yield, @function
lwp_yield:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	lwp_yield, .-lwp_yield
	.globl	lwp_start
	.type	lwp_start, @function
lwp_start:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	lwp_start, .-lwp_start
	.globl	lwp_stop
	.type	lwp_stop, @function
lwp_stop:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	lwp_stop, .-lwp_stop
	.globl	lwp_set_scheduler
	.type	lwp_set_scheduler, @function
lwp_set_scheduler:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L14
	movq	$round_robin, scheduler(%rip)
	jmp	.L13
.L14:
	movq	-8(%rbp), %rax
	movq	%rax, scheduler(%rip)
.L13:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	lwp_set_scheduler, .-lwp_set_scheduler
	.section	.rodata
.LC0:
	.string	"malloc failure"
	.text
	.globl	malloc_s
	.type	malloc_s, @function
malloc_s:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L17
	movq	-8(%rbp), %rax
	jmp	.L19
.L17:
	movl	$.LC0, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	malloc_s, .-malloc_s
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
