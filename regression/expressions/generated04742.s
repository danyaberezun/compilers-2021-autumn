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
# LD x0
	movl	global_x0,	%ebx
# CONST 36
	movl	$36,	%ecx
# LD x0
	movl	global_x0,	%esi
# BINOP +
	addl	%esi,	%ecx
	movl	%ecx,	%ecx
# CONST 40
	movl	$40,	%esi
# BINOP +
	addl	%esi,	%ecx
	movl	%ecx,	%ecx
# BINOP *
	imull	%ecx,	%ebx
	movl	%ebx,	%ebx
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
