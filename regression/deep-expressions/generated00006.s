	.global	main
	.data
global_x0:	.int	0
global_x1:	.int	0
global_x2:	.int	0
global_x3:	.int	0
global_y:	.int	0
	.text
main:
	pushl	%ebp
	movl	%esp,	%ebp
	subl	$20,	%esp
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
# READ
	call	Lread
	movl	%eax,	%ebx
# ST x2
	movl	%ebx,	global_x2
# READ
	call	Lread
	movl	%eax,	%ebx
# ST x3
	movl	%ebx,	global_x3
# LD x1
	movl	global_x1,	%ebx
# CONST 690
	movl	$690,	%ecx
# BINOP >
	cmpl	%ecx,	%ebx
	setg	%al
	movl	%eax,	%ebx
# LD x2
	movl	global_x2,	%ecx
# CONST 545
	movl	$545,	%esi
# BINOP !!
	orl	%esi,	%ecx
	cmpl	$0,	%ecx
	setne	%al
	movl	%eax,	%ecx
# BINOP <
	cmpl	%ecx,	%ebx
	setl	%al
	movl	%eax,	%ebx
# LD x3
	movl	global_x3,	%ecx
# CONST 85
	movl	$85,	%esi
# BINOP &&
	andl	%esi,	%ecx
	cmpl	$0,	%ecx
	setne	%al
	movl	%eax,	%ecx
# LD x3
	movl	global_x3,	%esi
# CONST 497
	movl	$497,	%edi
# BINOP -
	subl	%edi,	%esi
# BINOP >
	cmpl	%esi,	%ecx
	setg	%al
	movl	%eax,	%ecx
# BINOP >=
	cmpl	%ecx,	%ebx
	setge	%al
	movl	%eax,	%ebx
# CONST 837
	movl	$837,	%ecx
# LD x1
	movl	global_x1,	%esi
# BINOP -
	subl	%esi,	%ecx
# LD x1
	movl	global_x1,	%esi
# LD x0
	movl	global_x0,	%edi
# BINOP !=
	cmpl	%edi,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# CONST 791
	movl	$791,	%esi
# CONST 575
	movl	$575,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# CONST 864
	movl	$864,	%edi
# CONST 231
	movl	$231,	-4(%ebp)
# BINOP <
	cmpl	-4(%ebp),	%edi
	setl	%al
	movl	%eax,	%edi
# BINOP -
	subl	%edi,	%esi
# BINOP +
	addl	%esi,	%ecx
# BINOP &&
	andl	%ecx,	%ebx
	cmpl	$0,	%ebx
	setne	%al
	movl	%eax,	%ebx
# CONST 478
	movl	$478,	%ecx
# CONST 954
	movl	$954,	%esi
# BINOP !=
	cmpl	%esi,	%ecx
	setne	%al
	movl	%eax,	%ecx
# LD x3
	movl	global_x3,	%esi
# LD x1
	movl	global_x1,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# BINOP -
	subl	%esi,	%ecx
# LD x1
	movl	global_x1,	%esi
# LD x2
	movl	global_x2,	%edi
# BINOP >=
	cmpl	%edi,	%esi
	setge	%al
	movl	%eax,	%esi
# CONST 865
	movl	$865,	%edi
# CONST 544
	movl	$544,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# CONST 693
	movl	$693,	%esi
# CONST 830
	movl	$830,	%edi
# BINOP >=
	cmpl	%edi,	%esi
	setge	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# CONST 493
	movl	$493,	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP *
	imull	%edi,	%esi
# LD x1
	movl	global_x1,	%edi
# CONST 963
	movl	$963,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# CONST 690
	movl	$690,	-8(%ebp)
# BINOP &&
	andl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP !=
	cmpl	%esi,	%ecx
	setne	%al
	movl	%eax,	%ecx
# BINOP >
	cmpl	%ecx,	%ebx
	setg	%al
	movl	%eax,	%ebx
# LD x2
	movl	global_x2,	%ecx
# CONST 981
	movl	$981,	%esi
# BINOP *
	imull	%esi,	%ecx
# LD x0
	movl	global_x0,	%esi
# LD x2
	movl	global_x2,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# BINOP !!
	orl	%esi,	%ecx
	cmpl	$0,	%ecx
	setne	%al
	movl	%eax,	%ecx
# LD x1
	movl	global_x1,	%esi
# CONST 454
	movl	$454,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# CONST 742
	movl	$742,	%edi
# CONST 810
	movl	$810,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# BINOP >
	cmpl	%edi,	%esi
	setg	%al
	movl	%eax,	%esi
# BINOP *
	imull	%esi,	%ecx
# LD x1
	movl	global_x1,	%esi
# LD x0
	movl	global_x0,	%edi
# BINOP -
	subl	%edi,	%esi
# LD x3
	movl	global_x3,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP +
	addl	%edi,	%esi
# CONST 45
	movl	$45,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# CONST 201
	movl	$201,	-4(%ebp)
# CONST 599
	movl	$599,	-8(%ebp)
# BINOP <=
	cmpl	-8(%ebp),	-4(%ebp)
	setle	%al
	movl	%eax,	-4(%ebp)
# BINOP *
	imull	-4(%ebp),	%edi
# BINOP !=
	cmpl	%edi,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP +
	addl	%esi,	%ecx
# LD x0
	movl	global_x0,	%esi
# LD x1
	movl	global_x1,	%edi
# BINOP *
	imull	%edi,	%esi
# LD x3
	movl	global_x3,	%edi
# CONST 138
	movl	$138,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP +
	addl	%edi,	%esi
# LD x1
	movl	global_x1,	%edi
# CONST 725
	movl	$725,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP >
	cmpl	-8(%ebp),	-4(%ebp)
	setg	%al
	movl	%eax,	-4(%ebp)
# BINOP *
	imull	-4(%ebp),	%edi
# BINOP <=
	cmpl	%edi,	%esi
	setle	%al
	movl	%eax,	%esi
# CONST 678
	movl	$678,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP >
	cmpl	-8(%ebp),	-4(%ebp)
	setg	%al
	movl	%eax,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# CONST 925
	movl	$925,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# BINOP *
	imull	-8(%ebp),	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# CONST 468
	movl	$468,	-12(%ebp)
# BINOP <
	cmpl	-12(%ebp),	-8(%ebp)
	setl	%al
	movl	%eax,	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# BINOP &&
	andl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# BINOP >=
	cmpl	%ecx,	%ebx
	setge	%al
	movl	%eax,	%ebx
# LD x0
	movl	global_x0,	%ecx
# CONST 984
	movl	$984,	%esi
# BINOP <=
	cmpl	%esi,	%ecx
	setle	%al
	movl	%eax,	%ecx
# CONST 775
	movl	$775,	%esi
# LD x1
	movl	global_x1,	%edi
# BINOP &&
	andl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP <
	cmpl	%esi,	%ecx
	setl	%al
	movl	%eax,	%ecx
# CONST 908
	movl	$908,	%esi
# LD x0
	movl	global_x0,	%edi
# BINOP +
	addl	%edi,	%esi
# LD x1
	movl	global_x1,	%edi
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# BINOP *
	imull	%edi,	%esi
# BINOP -
	subl	%esi,	%ecx
# CONST 102
	movl	$102,	%esi
# CONST 68
	movl	$68,	%edi
# BINOP -
	subl	%edi,	%esi
# CONST 709
	movl	$709,	%edi
# CONST 546
	movl	$546,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# BINOP >=
	cmpl	%edi,	%esi
	setge	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# CONST 722
	movl	$722,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP <=
	cmpl	-8(%ebp),	-4(%ebp)
	setle	%al
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# BINOP *
	imull	%edi,	%esi
# BINOP ==
	cmpl	%esi,	%ecx
	sete	%al
	movl	%eax,	%ecx
# LD x1
	movl	global_x1,	%esi
# LD x2
	movl	global_x2,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# CONST 22
	movl	$22,	%edi
# CONST 492
	movl	$492,	-4(%ebp)
# BINOP !!
	orl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP >
	cmpl	%edi,	%esi
	setg	%al
	movl	%eax,	%esi
# LD x2
	movl	global_x2,	%edi
# CONST 357
	movl	$357,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# CONST 701
	movl	$701,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# BINOP >
	cmpl	-8(%ebp),	-4(%ebp)
	setg	%al
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# BINOP *
	imull	%edi,	%esi
# CONST 924
	movl	$924,	%edi
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# BINOP !!
	orl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# CONST 937
	movl	$937,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-12(%ebp)
# BINOP >=
	cmpl	-12(%ebp),	-8(%ebp)
	setge	%al
	movl	%eax,	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# BINOP *
	imull	%esi,	%ecx
# LD x0
	movl	global_x0,	%esi
# LD x0
	movl	global_x0,	%edi
# BINOP <=
	cmpl	%edi,	%esi
	setle	%al
	movl	%eax,	%esi
# CONST 158
	movl	$158,	%edi
# CONST 474
	movl	$474,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# BINOP <=
	cmpl	%edi,	%esi
	setle	%al
	movl	%eax,	%esi
# CONST 552
	movl	$552,	%edi
# CONST 414
	movl	$414,	-4(%ebp)
# BINOP *
	imull	-4(%ebp),	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP <
	cmpl	-4(%ebp),	%edi
	setl	%al
	movl	%eax,	%edi
# BINOP >
	cmpl	%edi,	%esi
	setg	%al
	movl	%eax,	%esi
# LD x1
	movl	global_x1,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP !=
	cmpl	-4(%ebp),	%edi
	setne	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# CONST 921
	movl	$921,	-8(%ebp)
# BINOP *
	imull	-8(%ebp),	-4(%ebp)
# BINOP !=
	cmpl	-4(%ebp),	%edi
	setne	%al
	movl	%eax,	%edi
# CONST 522
	movl	$522,	-4(%ebp)
# CONST 704
	movl	$704,	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# CONST 361
	movl	$361,	-8(%ebp)
# CONST 952
	movl	$952,	-12(%ebp)
# BINOP !!
	orl	-12(%ebp),	-8(%ebp)
	cmpl	$0,	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# CONST 326
	movl	$326,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# CONST 860
	movl	$860,	-4(%ebp)
# CONST 539
	movl	$539,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# CONST 173
	movl	$173,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# CONST 353
	movl	$353,	-8(%ebp)
# CONST 225
	movl	$225,	-12(%ebp)
# BINOP +
	addl	-12(%ebp),	-8(%ebp)
# BINOP >
	cmpl	-8(%ebp),	-4(%ebp)
	setg	%al
	movl	%eax,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP &&
	andl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# CONST 875
	movl	$875,	-8(%ebp)
# CONST 444
	movl	$444,	-12(%ebp)
# BINOP -
	subl	-12(%ebp),	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# CONST 506
	movl	$506,	-12(%ebp)
# BINOP *
	imull	-12(%ebp),	-8(%ebp)
# CONST 899
	movl	$899,	-12(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-16(%ebp)
# BINOP !!
	orl	-16(%ebp),	-12(%ebp)
	cmpl	$0,	-12(%ebp)
	setne	%al
	movl	%eax,	-12(%ebp)
# BINOP +
	addl	-12(%ebp),	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# BINOP -
	subl	%esi,	%ecx
# BINOP !!
	orl	%ecx,	%ebx
	cmpl	$0,	%ebx
	setne	%al
	movl	%eax,	%ebx
# LD x0
	movl	global_x0,	%ecx
# LD x2
	movl	global_x2,	%esi
# BINOP <=
	cmpl	%esi,	%ecx
	setle	%al
	movl	%eax,	%ecx
# LD x2
	movl	global_x2,	%esi
# LD x2
	movl	global_x2,	%edi
# BINOP -
	subl	%edi,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# CONST 577
	movl	$577,	%esi
# CONST 270
	movl	$270,	%edi
# BINOP +
	addl	%edi,	%esi
# LD x1
	movl	global_x1,	%edi
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# LD x3
	movl	global_x3,	%esi
# CONST 440
	movl	$440,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP &&
	andl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# LD x0
	movl	global_x0,	%edi
# CONST 673
	movl	$673,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# CONST 878
	movl	$878,	-4(%ebp)
# CONST 394
	movl	$394,	-8(%ebp)
# BINOP <
	cmpl	-8(%ebp),	-4(%ebp)
	setl	%al
	movl	%eax,	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP -
	subl	%edi,	%esi
# BINOP >=
	cmpl	%esi,	%ecx
	setge	%al
	movl	%eax,	%ecx
# CONST 679
	movl	$679,	%esi
# CONST 437
	movl	$437,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# CONST 594
	movl	$594,	-4(%ebp)
# BINOP !!
	orl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP &&
	andl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# LD x1
	movl	global_x1,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# CONST 377
	movl	$377,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# LD x2
	movl	global_x2,	%edi
# CONST 63
	movl	$63,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# CONST 749
	movl	$749,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# CONST 806
	movl	$806,	-4(%ebp)
# CONST 882
	movl	$882,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# CONST 367
	movl	$367,	-8(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-12(%ebp)
# BINOP +
	addl	-12(%ebp),	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP *
	imull	%edi,	%esi
# BINOP +
	addl	%esi,	%ecx
# LD x1
	movl	global_x1,	%esi
# CONST 54
	movl	$54,	%edi
# BINOP >=
	cmpl	%edi,	%esi
	setge	%al
	movl	%eax,	%esi
# LD x0
	movl	global_x0,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# BINOP <=
	cmpl	%edi,	%esi
	setle	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# CONST 628
	movl	$628,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# CONST 995
	movl	$995,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# BINOP <=
	cmpl	-8(%ebp),	-4(%ebp)
	setle	%al
	movl	%eax,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# LD x2
	movl	global_x2,	%edi
# CONST 879
	movl	$879,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# CONST 111
	movl	$111,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# BINOP &&
	andl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# CONST 711
	movl	$711,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# CONST 123
	movl	$123,	-12(%ebp)
# BINOP !=
	cmpl	-12(%ebp),	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP -
	subl	-4(%ebp),	%edi
# BINOP ==
	cmpl	%edi,	%esi
	sete	%al
	movl	%eax,	%esi
# CONST 953
	movl	$953,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# CONST 373
	movl	$373,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# CONST 848
	movl	$848,	-4(%ebp)
# CONST 679
	movl	$679,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# CONST 496
	movl	$496,	-8(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-12(%ebp)
# BINOP &&
	andl	-12(%ebp),	-8(%ebp)
	cmpl	$0,	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# CONST 660
	movl	$660,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# BINOP &&
	andl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# CONST 179
	movl	$179,	-8(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-12(%ebp)
# BINOP ==
	cmpl	-12(%ebp),	-8(%ebp)
	sete	%al
	movl	%eax,	-8(%ebp)
# BINOP *
	imull	-8(%ebp),	-4(%ebp)
# CONST 455
	movl	$455,	-8(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-12(%ebp)
# BINOP *
	imull	-12(%ebp),	-8(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-12(%ebp)
# CONST 53
	movl	$53,	-16(%ebp)
# BINOP >=
	cmpl	-16(%ebp),	-12(%ebp)
	setge	%al
	movl	%eax,	-12(%ebp)
# BINOP -
	subl	-12(%ebp),	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP &&
	andl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP ==
	cmpl	%edi,	%esi
	sete	%al
	movl	%eax,	%esi
# BINOP *
	imull	%esi,	%ecx
# LD x0
	movl	global_x0,	%esi
# CONST 258
	movl	$258,	%edi
# BINOP *
	imull	%edi,	%esi
# LD x2
	movl	global_x2,	%edi
# CONST 918
	movl	$918,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# BINOP &&
	andl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# CONST 644
	movl	$644,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# BINOP !=
	cmpl	-4(%ebp),	%edi
	setne	%al
	movl	%eax,	%edi
# CONST 939
	movl	$939,	-4(%ebp)
# CONST 788
	movl	$788,	-8(%ebp)
# BINOP <=
	cmpl	-8(%ebp),	-4(%ebp)
	setle	%al
	movl	%eax,	-4(%ebp)
# BINOP !!
	orl	-4(%ebp),	%edi
	cmpl	$0,	%edi
	setne	%al
	movl	%eax,	%edi
# BINOP !!
	orl	%edi,	%esi
	cmpl	$0,	%esi
	setne	%al
	movl	%eax,	%esi
# LD x0
	movl	global_x0,	%edi
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# CONST 889
	movl	$889,	-4(%ebp)
# CONST 108
	movl	$108,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# CONST 704
	movl	$704,	-12(%ebp)
# BINOP !=
	cmpl	-12(%ebp),	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP ==
	cmpl	-8(%ebp),	-4(%ebp)
	sete	%al
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# BINOP -
	subl	%edi,	%esi
# LD x2
	movl	global_x2,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# CONST 507
	movl	$507,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# BINOP ==
	cmpl	-8(%ebp),	-4(%ebp)
	sete	%al
	movl	%eax,	-4(%ebp)
# BINOP +
	addl	-4(%ebp),	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# CONST 856
	movl	$856,	-8(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-12(%ebp)
# BINOP *
	imull	-12(%ebp),	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP >
	cmpl	-4(%ebp),	%edi
	setg	%al
	movl	%eax,	%edi
# CONST 275
	movl	$275,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# BINOP ==
	cmpl	-8(%ebp),	-4(%ebp)
	sete	%al
	movl	%eax,	-4(%ebp)
# CONST 715
	movl	$715,	-8(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-12(%ebp)
# BINOP >=
	cmpl	-12(%ebp),	-8(%ebp)
	setge	%al
	movl	%eax,	-8(%ebp)
# BINOP +
	addl	-8(%ebp),	-4(%ebp)
# CONST 814
	movl	$814,	-8(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-12(%ebp)
# BINOP -
	subl	-12(%ebp),	-8(%ebp)
# CONST 274
	movl	$274,	-12(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-16(%ebp)
# BINOP &&
	andl	-16(%ebp),	-12(%ebp)
	cmpl	$0,	-12(%ebp)
	setne	%al
	movl	%eax,	-12(%ebp)
# BINOP <
	cmpl	-12(%ebp),	-8(%ebp)
	setl	%al
	movl	%eax,	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# BINOP *
	imull	-4(%ebp),	%edi
# BINOP <
	cmpl	%edi,	%esi
	setl	%al
	movl	%eax,	%esi
# LD x3
	movl	global_x3,	%edi
# CONST 304
	movl	$304,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP -
	subl	-8(%ebp),	-4(%ebp)
# BINOP >=
	cmpl	-4(%ebp),	%edi
	setge	%al
	movl	%eax,	%edi
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-4(%ebp)
# CONST 278
	movl	$278,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-12(%ebp)
# BINOP !!
	orl	-12(%ebp),	-8(%ebp)
	cmpl	$0,	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP !=
	cmpl	-8(%ebp),	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP <=
	cmpl	-4(%ebp),	%edi
	setle	%al
	movl	%eax,	%edi
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# BINOP !!
	orl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# LD x0
	movl	global_x0,	%eax
	movl	%eax,	-8(%ebp)
# CONST 618
	movl	$618,	-12(%ebp)
# BINOP <=
	cmpl	-12(%ebp),	-8(%ebp)
	setle	%al
	movl	%eax,	-8(%ebp)
# BINOP ==
	cmpl	-8(%ebp),	-4(%ebp)
	sete	%al
	movl	%eax,	-4(%ebp)
# CONST 55
	movl	$55,	-8(%ebp)
# CONST 612
	movl	$612,	-12(%ebp)
# BINOP !=
	cmpl	-12(%ebp),	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# CONST 195
	movl	$195,	-12(%ebp)
# CONST 602
	movl	$602,	-16(%ebp)
# BINOP <
	cmpl	-16(%ebp),	-12(%ebp)
	setl	%al
	movl	%eax,	-12(%ebp)
# BINOP !=
	cmpl	-12(%ebp),	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP &&
	andl	-8(%ebp),	-4(%ebp)
	cmpl	$0,	-4(%ebp)
	setne	%al
	movl	%eax,	-4(%ebp)
# BINOP ==
	cmpl	-4(%ebp),	%edi
	sete	%al
	movl	%eax,	%edi
# CONST 430
	movl	$430,	-4(%ebp)
# CONST 22
	movl	$22,	-8(%ebp)
# BINOP <
	cmpl	-8(%ebp),	-4(%ebp)
	setl	%al
	movl	%eax,	-4(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-8(%ebp)
# CONST 477
	movl	$477,	-12(%ebp)
# BINOP &&
	andl	-12(%ebp),	-8(%ebp)
	cmpl	$0,	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP <=
	cmpl	-8(%ebp),	-4(%ebp)
	setle	%al
	movl	%eax,	-4(%ebp)
# LD x2
	movl	global_x2,	%eax
	movl	%eax,	-8(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-12(%ebp)
# BINOP >
	cmpl	-12(%ebp),	-8(%ebp)
	setg	%al
	movl	%eax,	-8(%ebp)
# CONST 16
	movl	$16,	-12(%ebp)
# CONST 653
	movl	$653,	-16(%ebp)
# BINOP >
	cmpl	-16(%ebp),	-12(%ebp)
	setg	%al
	movl	%eax,	-12(%ebp)
# BINOP *
	imull	-12(%ebp),	-8(%ebp)
# BINOP >=
	cmpl	-8(%ebp),	-4(%ebp)
	setge	%al
	movl	%eax,	-4(%ebp)
# LD x3
	movl	global_x3,	%eax
	movl	%eax,	-8(%ebp)
# CONST 570
	movl	$570,	-12(%ebp)
# BINOP -
	subl	-12(%ebp),	-8(%ebp)
# LD x1
	movl	global_x1,	%eax
	movl	%eax,	-12(%ebp)
# CONST 423
	movl	$423,	-16(%ebp)
# BINOP >
	cmpl	-16(%ebp),	-12(%ebp)
	setg	%al
	movl	%eax,	-12(%ebp)
# BINOP <
	cmpl	-12(%ebp),	-8(%ebp)
	setl	%al
	movl	%eax,	-8(%ebp)
# CONST 613
	movl	$613,	-12(%ebp)
# CONST 756
	movl	$756,	-16(%ebp)
# BINOP !!
	orl	-16(%ebp),	-12(%ebp)
	cmpl	$0,	-12(%ebp)
	setne	%al
	movl	%eax,	-12(%ebp)
# CONST 672
	movl	$672,	-16(%ebp)
# CONST 542
	movl	$542,	-20(%ebp)
# BINOP >
	cmpl	-20(%ebp),	-16(%ebp)
	setg	%al
	movl	%eax,	-16(%ebp)
# BINOP +
	addl	-16(%ebp),	-12(%ebp)
# BINOP !=
	cmpl	-12(%ebp),	-8(%ebp)
	setne	%al
	movl	%eax,	-8(%ebp)
# BINOP ==
	cmpl	-8(%ebp),	-4(%ebp)
	sete	%al
	movl	%eax,	-4(%ebp)
# BINOP *
	imull	-4(%ebp),	%edi
# BINOP >=
	cmpl	%edi,	%esi
	setge	%al
	movl	%eax,	%esi
# BINOP &&
	andl	%esi,	%ecx
	cmpl	$0,	%ecx
	setne	%al
	movl	%eax,	%ecx
# BINOP !!
	orl	%ecx,	%ebx
	cmpl	$0,	%ebx
	setne	%al
	movl	%eax,	%ebx
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
