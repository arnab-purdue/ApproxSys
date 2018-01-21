	.file	"main.cpp"
	.section	.rodata
.LC1:
	.string	"-- entering main function --\r"
.LC2:
	.string	"-- loading image --\r"
.LC3:
	.string	"Face.pgm"
.LC4:
	.string	"Unable to open input image"
	.align 8
.LC5:
	.string	"-- loading cascade classifier --\r"
.LC6:
	.string	"-- detecting faces --\r"
.LC7:
	.string	"-- saving output --\r"
.LC8:
	.string	"Output.pgm"
.LC9:
	.string	"-- image saved --\r"
.LC11:
	.string	"Main = %f\n"
.globl _Unwind_Resume
	.text
.globl main
	.type	main, @function
main:
.LFB435:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA435
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$368, %rsp
	movl	%edi, -372(%rbp)
	movq	%rsi, -384(%rbp)
	movl	$1, -48(%rbp)
	movl	$0x3f99999a, %eax
	movl	%eax, -40(%rbp)
	movl	$1, -36(%rbp)
	movl	$.LC1, %edi
.LEHB0:
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	puts
	movl	$.LC2, %edi
	call	puts
	leaq	-224(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	call	readPgm
	movl	%eax, -52(%rbp)
	cmpl	$-1, -52(%rbp)
	jne	.L2
	movl	$.LC4, %edi
	call	puts
	movl	$1, %ebx
	jmp	.L3
.L2:
	movl	$.LC5, %edi
	call	puts
	leaq	-368(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	$20, -128(%rbp)
	movl	$20, -124(%rbp)
	movl	$0, -144(%rbp)
	movl	$0, -140(%rbp)
	movq	-24(%rbp), %rax
	movl	$25, (%rax)
	movq	-24(%rbp), %rax
	movl	$2913, 4(%rax)
	movq	-24(%rbp), %rax
	movl	$24, 16(%rax)
	movq	-24(%rbp), %rax
	movl	$24, 12(%rax)
	call	readTextClassifier
	call	clock
	movq	%rax, -80(%rbp)
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EEC1Ev
.LEHE0:
	movl	$.LC6, %edi
.LEHB1:
	call	puts
	leaq	-112(%rbp), %rax
	movl	-36(%rbp), %edi
	movss	-40(%rbp), %xmm0
	movq	-24(%rbp), %rsi
	movq	-144(%rbp), %rcx
	movq	-128(%rbp), %rdx
	movq	-32(%rbp), %rbx
	movl	%edi, %r9d
	movq	%rsi, %r8
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	detectObjects
.LEHE1:
	leaq	-112(%rbp), %rdx
	leaq	-176(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB2:
	call	_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_
.LEHE2:
	jmp	.L12
.L10:
.L5:
	movl	%edx, %ebx
	movq	%rax, %r12
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EED1Ev
	movq	%r12, %rax
	movslq	%ebx, %rdx
	jmp	.L8
.L12:
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
.LEHB3:
	call	_ZNSt6vectorI6MyRectSaIS0_EED1Ev
	call	clock
	movq	%rax, -72(%rbp)
	movl	$0, -44(%rbp)
	jmp	.L6
.L7:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	leaq	-176(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EEixEm
	movq	(%rax), %rdx
	movq	%rdx, -192(%rbp)
	movq	8(%rax), %rax
	movq	%rax, -184(%rbp)
	movq	-192(%rbp), %rcx
	movq	-184(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	drawRectangle
	addl	$1, -44(%rbp)
.L6:
	movl	-44(%rbp), %eax
	movslq	%eax, %rbx
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	cmpq	%rax, %rbx
	setb	%al
	testb	%al, %al
	jne	.L7
	movl	$.LC7, %edi
	call	puts
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC8, %edi
	call	writePgm
	movl	%eax, -52(%rbp)
	movl	$.LC9, %edi
	call	puts
	call	releaseTextClassifier
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	freeImage
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC10(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -64(%rbp)
	movsd	-64(%rbp), %xmm0
	movl	$.LC11, %edi
	movl	$1, %eax
	call	printf
.LEHE3:
	movl	$0, %ebx
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
.LEHB4:
	call	_ZNSt6vectorI6MyRectSaIS0_EED1Ev
.LEHE4:
	jmp	.L3
.L11:
.L8:
	movl	%edx, %ebx
	movq	%rax, %r12
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EED1Ev
	movq	%r12, %rax
	movslq	%ebx, %rdx
	movq	%rax, %rdi
.LEHB5:
	call	_Unwind_Resume
.LEHE5:
.L3:
	movl	%ebx, %eax
	addq	$368, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE435:
	.size	main, .-main
.globl __gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA435:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE435-.LLSDACSB435
.LLSDACSB435:
	.uleb128 .LEHB0-.LFB435
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 .LEHB1-.LFB435
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L11-.LFB435
	.uleb128 0x0
	.uleb128 .LEHB2-.LFB435
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L10-.LFB435
	.uleb128 0x0
	.uleb128 .LEHB3-.LFB435
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L11-.LFB435
	.uleb128 0x0
	.uleb128 .LEHB4-.LFB435
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 .LEHB5-.LFB435
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0x0
	.uleb128 0x0
.LLSDACSE435:
	.text
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EEC2Ev,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EEC5Ev,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EEC2Ev
	.type	_ZNSt6vectorI6MyRectSaIS0_EEC2Ev, @function
_ZNSt6vectorI6MyRectSaIS0_EEC2Ev:
.LFB438:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE438:
	.size	_ZNSt6vectorI6MyRectSaIS0_EEC2Ev, .-_ZNSt6vectorI6MyRectSaIS0_EEC2Ev
	.weak	_ZNSt6vectorI6MyRectSaIS0_EEC1Ev
	.set	_ZNSt6vectorI6MyRectSaIS0_EEC1Ev,_ZNSt6vectorI6MyRectSaIS0_EEC2Ev
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EED2Ev,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EED5Ev,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EED2Ev
	.type	_ZNSt6vectorI6MyRectSaIS0_EED2Ev, @function
_ZNSt6vectorI6MyRectSaIS0_EED2Ev:
.LFB441:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA441
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB6:
	call	_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E
.LEHE6:
	jmp	.L21
.L20:
.L17:
	movl	%edx, %ebx
	movq	%rax, %r12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev
	movq	%r12, %rax
	movslq	%ebx, %rdx
	movq	%rax, %rdi
.LEHB7:
	call	_Unwind_Resume
.L21:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev
.LEHE7:
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE441:
	.size	_ZNSt6vectorI6MyRectSaIS0_EED2Ev, .-_ZNSt6vectorI6MyRectSaIS0_EED2Ev
	.section	.gcc_except_table
.LLSDA441:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE441-.LLSDACSB441
.LLSDACSB441:
	.uleb128 .LEHB6-.LFB441
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L20-.LFB441
	.uleb128 0x0
	.uleb128 .LEHB7-.LFB441
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0x0
	.uleb128 0x0
.LLSDACSE441:
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EED2Ev,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EED5Ev,comdat
	.weak	_ZNSt6vectorI6MyRectSaIS0_EED1Ev
	.set	_ZNSt6vectorI6MyRectSaIS0_EED1Ev,_ZNSt6vectorI6MyRectSaIS0_EED2Ev
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_
	.type	_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_, @function
_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_:
.LFB443:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	-56(%rbp), %rax
	je	.L23
	.cfi_offset 3, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv
	cmpq	-48(%rbp), %rax
	setb	%al
	testb	%al, %al
	je	.L24
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE3endEv
	movq	%rax, %r12
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv
	movq	%rax, %rdx
	movq	-48(%rbp), %rbx
	movq	-56(%rbp), %rax
	movq	%r12, %rcx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_
	movq	%rax, -40(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E
	movq	-56(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	(%rax), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	-48(%rbp), %rdx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, 16(%rax)
	jmp	.L25
.L24:
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	cmpq	-48(%rbp), %rax
	setae	%al
	testb	%al, %al
	je	.L26
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	movq	%rax, %r12
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EE3endEv
	movq	%rax, %rbx
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorI6MyRectSaIS0_EE5beginEv
	movq	%rax, %r14
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE3endEv
	movq	%rax, %r13
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%rax, %rdi
	call	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E
	jmp	.L25
.L26:
	movq	-56(%rbp), %rax
	movq	(%rax), %rbx
	movq	-64(%rbp), %rax
	movq	(%rax), %r12
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	salq	$4, %rax
	leaq	(%r12,%rax), %rcx
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rbx, %rdx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	movq	%rax, %r13
	movq	-56(%rbp), %rax
	movq	8(%rax), %r12
	movq	-64(%rbp), %rax
	movq	8(%rax), %rbx
	movq	-64(%rbp), %rax
	movq	(%rax), %r14
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	salq	$4, %rax
	leaq	(%r14,%rax), %rax
	movq	%r13, %rcx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E
.L25:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	-48(%rbp), %rdx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, 8(%rax)
.L23:
	movq	-56(%rbp), %rax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE443:
	.size	_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_, .-_ZNSt6vectorI6MyRectSaIS0_EEaSERKS2_
	.section	.text._ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv,"axG",@progbits,_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv,comdat
	.align 2
	.weak	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	.type	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv, @function
_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv:
.LFB444:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE444:
	.size	_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv, .-_ZNKSt6vectorI6MyRectSaIS0_EE4sizeEv
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EEixEm,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EEixEm,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EEixEm
	.type	_ZNSt6vectorI6MyRectSaIS0_EEixEm, @function
_ZNSt6vectorI6MyRectSaIS0_EEixEm:
.LFB445:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE445:
	.size	_ZNSt6vectorI6MyRectSaIS0_EEixEm, .-_ZNSt6vectorI6MyRectSaIS0_EEixEm
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev:
.LFB450:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaI6MyRectED2Ev
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE450:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD1Ev
	.set	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD1Ev,_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD2Ev
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EEC5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev:
.LFB452:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC1Ev
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE452:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC1Ev
	.set	_ZNSt12_Vector_baseI6MyRectSaIS0_EEC1Ev,_ZNSt12_Vector_baseI6MyRectSaIS0_EEC2Ev
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EED5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev:
.LFB455:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA455
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB8:
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m
.LEHE8:
	jmp	.L43
.L42:
.L39:
	movl	%edx, %ebx
	movq	%rax, %r12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD1Ev
	movq	%r12, %rax
	movslq	%ebx, %rdx
	movq	%rax, %rdi
.LEHB9:
	call	_Unwind_Resume
.LEHE9:
.L43:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implD1Ev
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE455:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev
	.section	.gcc_except_table
.LLSDA455:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE455-.LLSDACSB455
.LLSDACSB455:
	.uleb128 .LEHB8-.LFB455
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L42-.LFB455
	.uleb128 0x0
	.uleb128 .LEHB9-.LFB455
	.uleb128 .LEHE9-.LEHB9
	.uleb128 0x0
	.uleb128 0x0
.LLSDACSE455:
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EED5Ev,comdat
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EED1Ev
	.set	_ZNSt12_Vector_baseI6MyRectSaIS0_EED1Ev,_ZNSt12_Vector_baseI6MyRectSaIS0_EED2Ev
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv:
.LFB457:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE457:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	.section	.text._ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E,"axG",@progbits,_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E,comdat
	.weak	_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E
	.type	_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E, @function
_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E:
.LFB458:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZSt8_DestroyIP6MyRectEvT_S2_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE458:
	.size	_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E, .-_ZSt8_DestroyIP6MyRectS0_EvT_S2_RSaIT0_E
	.section	.text._ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv,"axG",@progbits,_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv,comdat
	.align 2
	.weak	_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv
	.type	_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv, @function
_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv:
.LFB459:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE459:
	.size	_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv, .-_ZNKSt6vectorI6MyRectSaIS0_EE8capacityEv
	.section	.text._ZNKSt6vectorI6MyRectSaIS0_EE5beginEv,"axG",@progbits,_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv,comdat
	.align 2
	.weak	_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv
	.type	_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv, @function
_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv:
.LFB460:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	-8(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS3_
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE460:
	.size	_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv, .-_ZNKSt6vectorI6MyRectSaIS0_EE5beginEv
	.section	.text._ZNKSt6vectorI6MyRectSaIS0_EE3endEv,"axG",@progbits,_ZNKSt6vectorI6MyRectSaIS0_EE3endEv,comdat
	.align 2
	.weak	_ZNKSt6vectorI6MyRectSaIS0_EE3endEv
	.type	_ZNKSt6vectorI6MyRectSaIS0_EE3endEv, @function
_ZNKSt6vectorI6MyRectSaIS0_EE3endEv:
.LFB461:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	-8(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS3_
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE461:
	.size	_ZNKSt6vectorI6MyRectSaIS0_EE3endEv, .-_ZNKSt6vectorI6MyRectSaIS0_EE3endEv
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_
	.type	_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_, @function
_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_:
.LFB462:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA462
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -64(%rbp)
	movq	%rcx, -80(%rbp)
	movq	-40(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB10:
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm
.LEHE10:
	movq	%rax, -24(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rcx
	movq	-24(%rbp), %rdx
	movq	-80(%rbp), %rbx
	movq	-64(%rbp), %rax
	movq	%rbx, %rsi
	movq	%rax, %rdi
.LEHB11:
	call	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E
.LEHE11:
	movq	-24(%rbp), %rax
	addq	$64, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L60:
	.cfi_restore_state
.L55:
	movq	%rax, %rdi
	call	__cxa_begin_catch
	movq	-40(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB12:
	call	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m
	call	__cxa_rethrow
.LEHE12:
.L59:
.L56:
	movl	%edx, %ebx
	movq	%rax, %r12
	call	__cxa_end_catch
	movq	%r12, %rax
	movslq	%ebx, %rdx
	movq	%rax, %rdi
.LEHB13:
	call	_Unwind_Resume
.LEHE13:
	.cfi_endproc
.LFE462:
	.size	_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_, .-_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_
	.section	.gcc_except_table
	.align 4
.LLSDA462:
	.byte	0xff
	.byte	0x3
	.uleb128 .LLSDATT462-.LLSDATTD462
.LLSDATTD462:
	.byte	0x1
	.uleb128 .LLSDACSE462-.LLSDACSB462
.LLSDACSB462:
	.uleb128 .LEHB10-.LFB462
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 .LEHB11-.LFB462
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L60-.LFB462
	.uleb128 0x1
	.uleb128 .LEHB12-.LFB462
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L59-.LFB462
	.uleb128 0x0
	.uleb128 .LEHB13-.LFB462
	.uleb128 .LEHE13-.LEHB13
	.uleb128 0x0
	.uleb128 0x0
.LLSDACSE462:
	.byte	0x1
	.byte	0x0
	.align 4
	.long	0

.LLSDATT462:
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKS0_S2_EEEEPS0_mT_SA_,comdat
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m:
.LFB463:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L63
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m
.L63:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE463:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EE13_M_deallocateEPS0_m
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EE5beginEv,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EE5beginEv,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EE5beginEv
	.type	_ZNSt6vectorI6MyRectSaIS0_EE5beginEv, @function
_ZNSt6vectorI6MyRectSaIS0_EE5beginEv:
.LFB464:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS2_
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE464:
	.size	_ZNSt6vectorI6MyRectSaIS0_EE5beginEv, .-_ZNSt6vectorI6MyRectSaIS0_EE5beginEv
	.section	.text._ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_,"axG",@progbits,_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_,comdat
	.weak	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_
	.type	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_, @function
_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_:
.LFB465:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -64(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -24
	call	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	movq	%rax, %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	movq	-64(%rbp), %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_
	addq	$56, %rsp
	popq	%rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE465:
	.size	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_, .-_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET0_T_SC_SB_
	.section	.text._ZNSt6vectorI6MyRectSaIS0_EE3endEv,"axG",@progbits,_ZNSt6vectorI6MyRectSaIS0_EE3endEv,comdat
	.align 2
	.weak	_ZNSt6vectorI6MyRectSaIS0_EE3endEv
	.type	_ZNSt6vectorI6MyRectSaIS0_EE3endEv, @function
_ZNSt6vectorI6MyRectSaIS0_EE3endEv:
.LFB466:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	leaq	8(%rax), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS2_
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE466:
	.size	_ZNSt6vectorI6MyRectSaIS0_EE3endEv, .-_ZNSt6vectorI6MyRectSaIS0_EE3endEv
	.section	.text._ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E,"axG",@progbits,_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E,comdat
	.weak	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E
	.type	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E, @function
_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E:
.LFB467:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE467:
	.size	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E, .-_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEES2_EvT_S8_RSaIT0_E
	.section	.text._ZSt4copyIP6MyRectS1_ET0_T_S3_S2_,"axG",@progbits,_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_,comdat
	.weak	_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_
	.type	_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_, @function
_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_:
.LFB468:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -24
	call	_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_
	movq	-40(%rbp), %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_
	addq	$40, %rsp
	popq	%rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE468:
	.size	_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_, .-_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_
	.section	.text._ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E,"axG",@progbits,_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E,comdat
	.weak	_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E
	.type	_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E, @function
_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E:
.LFB469:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE469:
	.size	_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E, .-_ZSt22__uninitialized_copy_aIP6MyRectS1_S0_ET0_T_S3_S2_RSaIT1_E
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev:
.LFB471:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaI6MyRectEC2Ev
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 16(%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE471:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC1Ev
	.set	_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC1Ev,_ZNSt12_Vector_baseI6MyRectSaIS0_EE12_Vector_implC2Ev
	.section	.text._ZNSaI6MyRectED2Ev,"axG",@progbits,_ZNSaI6MyRectED5Ev,comdat
	.align 2
	.weak	_ZNSaI6MyRectED2Ev
	.type	_ZNSaI6MyRectED2Ev, @function
_ZNSaI6MyRectED2Ev:
.LFB474:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev
	leave
	.cfi_def_cfa 7, 8
	ret
.L80:
	.cfi_endproc
.LFE474:
	.size	_ZNSaI6MyRectED2Ev, .-_ZNSaI6MyRectED2Ev
	.weak	_ZNSaI6MyRectED1Ev
	.set	_ZNSaI6MyRectED1Ev,_ZNSaI6MyRectED2Ev
	.section	.text._ZSt8_DestroyIP6MyRectEvT_S2_,"axG",@progbits,_ZSt8_DestroyIP6MyRectEvT_S2_,comdat
	.weak	_ZSt8_DestroyIP6MyRectEvT_S2_
	.type	_ZSt8_DestroyIP6MyRectEvT_S2_, @function
_ZSt8_DestroyIP6MyRectEvT_S2_:
.LFB476:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE476:
	.size	_ZSt8_DestroyIP6MyRectEvT_S2_, .-_ZSt8_DestroyIP6MyRectEvT_S2_
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC5ERKS3_,comdat
	.align 2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_
	.type	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_, @function
_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_:
.LFB478:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE478:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_, .-_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS3_
	.set	_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS3_,_ZN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS3_
	.section	.text._ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm,"axG",@progbits,_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm
	.type	_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm, @function
_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm:
.LFB480:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L87
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv
	jmp	.L88
.L87:
	movl	$0, %eax
.L88:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE480:
	.size	_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm, .-_ZNSt12_Vector_baseI6MyRectSaIS0_EE11_M_allocateEm
	.section	.text._ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E,"axG",@progbits,_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E,comdat
	.weak	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E
	.type	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E, @function
_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E:
.LFB481:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE481:
	.size	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E, .-_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_S2_ET0_T_SB_SA_RSaIT1_E
	.section	.text._ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m,comdat
	.align 2
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m
	.type	_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m, @function
_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m:
.LFB482:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZdlPv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE482:
	.size	_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m, .-_ZN9__gnu_cxx13new_allocatorI6MyRectE10deallocateEPS1_m
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC5ERKS2_,comdat
	.align 2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_
	.type	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_, @function
_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_:
.LFB484:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE484:
	.size	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_, .-_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS2_
	.set	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS2_,_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC2ERKS2_
	.section	.text._ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_,"axG",@progbits,_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_,comdat
	.weak	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	.type	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_, @function
_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_:
.LFB486:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE486:
	.size	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_, .-_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	.section	.text._ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_,"axG",@progbits,_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_,comdat
	.weak	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_
	.type	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_, @function
_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_:
.LFB487:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$64, %rsp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_
	movq	%rax, %r12
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	movq	%rax, %rbx
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_
	movq	%rax, -24(%rbp)
	leaq	-24(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEEC1ERKS2_
	movq	-32(%rbp), %rax
	addq	$64, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE487:
	.size	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_, .-_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEENS1_IPS2_S7_EEET1_T0_SC_SB_
	.section	.text._ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_,"axG",@progbits,_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_,comdat
	.weak	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_
	.type	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_, @function
_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_:
.LFB488:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE488:
	.size	_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_, .-_ZSt8_DestroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEEEvT_S8_
	.section	.text._ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_,"axG",@progbits,_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_,comdat
	.weak	_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_
	.type	_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_, @function
_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_:
.LFB489:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE489:
	.size	_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_, .-_ZNSt12__miter_baseIP6MyRectLb0EE3__bES1_
	.section	.text._ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_,"axG",@progbits,_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_,comdat
	.weak	_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_
	.type	_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_, @function
_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_:
.LFB490:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	movq	%rax, %r12
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE490:
	.size	_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_, .-_ZSt14__copy_move_a2ILb0EP6MyRectS1_ET1_T0_S3_S2_
	.section	.text._ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_,"axG",@progbits,_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_,comdat
	.weak	_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_
	.type	_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_, @function
_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_:
.LFB491:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE491:
	.size	_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_, .-_ZSt18uninitialized_copyIP6MyRectS1_ET0_T_S3_S2_
	.section	.text._ZNSaI6MyRectEC2Ev,"axG",@progbits,_ZNSaI6MyRectEC5Ev,comdat
	.align 2
	.weak	_ZNSaI6MyRectEC2Ev
	.type	_ZNSaI6MyRectEC2Ev, @function
_ZNSaI6MyRectEC2Ev:
.LFB493:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev
	leave
	.cfi_def_cfa 7, 8
	ret
.L110:
	.cfi_endproc
.LFE493:
	.size	_ZNSaI6MyRectEC2Ev, .-_ZNSaI6MyRectEC2Ev
	.weak	_ZNSaI6MyRectEC1Ev
	.set	_ZNSaI6MyRectEC1Ev,_ZNSaI6MyRectEC2Ev
	.section	.text._ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorI6MyRectED5Ev,comdat
	.align 2
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev
	.type	_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev, @function
_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev:
.LFB496:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE496:
	.size	_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev, .-_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectED1Ev
	.set	_ZN9__gnu_cxx13new_allocatorI6MyRectED1Ev,_ZN9__gnu_cxx13new_allocatorI6MyRectED2Ev
	.section	.text._ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_,"axG",@progbits,_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_,comdat
	.weak	_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_
	.type	_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_, @function
_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_:
.LFB498:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE498:
	.size	_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_, .-_ZNSt12_Destroy_auxILb1EE9__destroyIP6MyRectEEvT_S4_
	.section	.text._ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv,comdat
	.align 2
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv
	.type	_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv, @function
_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv:
.LFB499:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv
	cmpq	-16(%rbp), %rax
	setb	%al
	movzbl	%al, %eax
	testq	%rax, %rax
	setne	%al
	testb	%al, %al
	je	.L118
	call	_ZSt17__throw_bad_allocv
.L118:
	movq	-16(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdi
	call	_Znwm
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE499:
	.size	_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv, .-_ZN9__gnu_cxx13new_allocatorI6MyRectE8allocateEmPKv
	.section	.text._ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_,"axG",@progbits,_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_,comdat
	.weak	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	.type	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_, @function
_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_:
.LFB500:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE500:
	.size	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_, .-_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	.section	.text._ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_,"axG",@progbits,_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_,comdat
	.weak	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	.type	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_, @function
_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_:
.LFB501:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	movq	(%rax), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE501:
	.size	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_, .-_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	.section	.text._ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_,"axG",@progbits,_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_,comdat
	.weak	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_
	.type	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_, @function
_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_:
.LFB502:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	movq	(%rax), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE502:
	.size	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_, .-_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES7_
	.section	.text._ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_,"axG",@progbits,_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_,comdat
	.weak	_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_
	.type	_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_, @function
_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_:
.LFB503:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movb	$1, -1(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE503:
	.size	_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_, .-_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_
	.section	.text._ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_,"axG",@progbits,_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_,comdat
	.weak	_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_
	.type	_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_, @function
_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_:
.LFB504:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE504:
	.size	_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_, .-_ZNSt12_Destroy_auxILb1EE9__destroyIN9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS4_SaIS4_EEEEEEvT_SA_
	.section	.text._ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_,"axG",@progbits,_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_,comdat
	.weak	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	.type	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_, @function
_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_:
.LFB505:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE505:
	.size	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_, .-_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	.section	.text._ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_,"axG",@progbits,_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_,comdat
	.weak	_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_
	.type	_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_, @function
_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_:
.LFB506:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movb	$1, -1(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE506:
	.size	_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_, .-_ZSt13__copy_move_aILb0EP6MyRectS1_ET1_T0_S3_S2_
	.section	.text._ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_,"axG",@progbits,_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_,comdat
	.weak	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_
	.type	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_, @function
_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_:
.LFB507:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt4copyIP6MyRectS1_ET0_T_S3_S2_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE507:
	.size	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_, .-_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIP6MyRectS3_EET0_T_S5_S4_
	.section	.text._ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorI6MyRectEC5Ev,comdat
	.align 2
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev
	.type	_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev, @function
_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev:
.LFB509:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE509:
	.size	_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev, .-_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev
	.weak	_ZN9__gnu_cxx13new_allocatorI6MyRectEC1Ev
	.set	_ZN9__gnu_cxx13new_allocatorI6MyRectEC1Ev,_ZN9__gnu_cxx13new_allocatorI6MyRectEC2Ev
	.section	.text._ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv,"axG",@progbits,_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv
	.type	_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv, @function
_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv:
.LFB511:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movabsq	$1152921504606846975, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE511:
	.size	_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv, .-_ZNK9__gnu_cxx13new_allocatorI6MyRectE8max_sizeEv
	.section	.text._ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_,"axG",@progbits,_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_,comdat
	.weak	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_
	.type	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_, @function
_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_:
.LFB512:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE512:
	.size	_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_, .-_ZNSt20__uninitialized_copyILb1EE18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS4_SaIS4_EEEEPS4_EET0_T_SD_SC_
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv:
.LFB513:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE513:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv:
.LFB514:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE514:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIP6MyRectSt6vectorIS1_SaIS1_EEE4baseEv
	.section	.text._ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_,"axG",@progbits,_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_,comdat
	.weak	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_
	.type	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_, @function
_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_:
.LFB515:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	movq	%rax, %rdx
	salq	$4, %rdx
	movq	-8(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memmove
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	sarq	$4, %rax
	salq	$4, %rax
	addq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE515:
	.size	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_, .-_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mI6MyRectEEPT_PKS4_S7_S5_
	.section	.text._ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_,"axG",@progbits,_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_,comdat
	.weak	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	.type	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_, @function
_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_:
.LFB516:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -24
	call	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	movq	%rax, %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb0EE3__bES8_
	movq	-56(%rbp), %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_
	addq	$56, %rsp
	popq	%rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE516:
	.size	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_, .-_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET0_T_SB_SA_
	.section	.text._ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_,"axG",@progbits,_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_,comdat
	.weak	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_
	.type	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_, @function
_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_:
.LFB517:
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	_ZNSt12__niter_baseIP6MyRectLb0EE3__bES1_
	movq	%rax, %r12
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	movq	%rax, %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12__niter_baseIN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEELb1EE3__bES8_
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt13__copy_move_aILb0EPK6MyRectPS0_ET1_T0_S5_S4_
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE517:
	.size	_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_, .-_ZSt14__copy_move_a2ILb0EN9__gnu_cxx17__normal_iteratorIPK6MyRectSt6vectorIS2_SaIS2_EEEEPS2_ET1_T0_SB_SA_
	.section	.rodata
	.align 8
.LC10:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-17)"
	.section	.note.GNU-stack,"",@progbits
