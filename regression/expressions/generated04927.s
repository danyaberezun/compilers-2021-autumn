	.global	main
	.data
global_x0:	.int	0
global_x1:	.int	0
global_y:	.int	0
	.text
main:
	pushl	%ebp
	movl	%esp,	%ebp
	subl	$0,	%esp
# READ
	call	Lread
	movl	%eax,	%ebx
# ST x0
	movl	%ebx,	global_x0
# READ
	call	Lread
	movl	%eax,	%ebx
# ST x1
	movl	%ebx,	global_x1
# CONST 27
	movl	$27,	%ebx
# CONST 28
	movl	$28,	%ecx
# BINOP +
	addl	%ecx,	%ebx
	movl	%ebx,	%ebx
# CONST 29
	movl	$29,	%ecx
# BINOP +
	addl	%ecx,	%ebx
	movl	%ebx,	%ebx
# LD x0
	movl	global_x0,	%ecx
# BINOP %
	movl	%ebx,	%eax
	xorl	%edx,	%edx
	cltd
	idivl	%ecx
	movl	%edx,	%ebx
# ST y
	movl	%ebx,	global_y
# LD y
	movl	global_y,	%ebx
# WRITE
	pushl	%ebx
	call	Lwrite
	popl	%eax
	movl	%ebp,	%esp
	popl	%ebp
	xorl	%eax,	%eax
	ret
