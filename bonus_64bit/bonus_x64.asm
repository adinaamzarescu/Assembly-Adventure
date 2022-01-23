section .text
	global intertwine

;; =========================================================================================================
;; 	intertwine
;; =========================================================================================================
intertwine:
;; Create a new stack frame
	enter 0, 0
;; Save the callee-saved registers
	push	r12
	push	r13
	push	r14
	push	r15
	push	rbx
;; Move the arguments to the preserved registers
	mov		r12, rdi					;; Set r12 to the first argument v1
	mov		r13, rsi					;; Set r13 to the second argument n1
	mov		r14, rdx					;; Set r14 to the third argument v2
	mov		r15, rcx					;; Set r15 to the fourth argument n2
	mov		rbx, r8						;; Set rbx to the fifth register v
;; Intialise the needed registers
	mov		r9,	0						;; Set the counter of v1 to 0
	mov		r10, 0						;; Set the counter of v2 to 0
	mov		r11, 0						;; Set the counter of v to 0


.loop:
;; Check if the current number should be copied from v1 or v2
	.endcond:
		;; Check if n1 is reached
		cmp		r9, r13
		jl		.cond1
		;; Check if n2 is reached
		cmp		r10, r15
		jl		.copyFromv2
		jmp		.end
	.cond1:
		;; Check if the current counter of v is pair
		mov		rax, r11
		mov		rcx, 2
		cqo
		div		rcx
		cmp		rdx, 0
		je		.copyFromv1
	.cond2:
		;; Check if n2 is reached
		cmp		r10, r15
		jl		.copyFromv2
		jmp		.copyFromv1


.end:
;; Restore the callee-saved registers
	pop		rbx
	pop		r15
	pop		r14
	pop		r13
	pop		r12
;; Destroy the current stack frame and return
	leave
	ret


.copyFromv1:
;; *v = *v1
	mov		edx, dword[r12]			;; Set edx to the current number in v1
	mov		dword[rbx], edx			;; Set the current number in v to edx
;; Increment the counteres of v1 and v
	inc		r9
	inc		r11
;; Increment the pointers v1 and v
	add		r12, 4
	add		rbx, 4
;; Move to the next number
	jmp		.loop


.copyFromv2:
;; *v = *v2
	mov		edx, dword[r14]					;; Set rdx to the current number in v2
	mov		dword[rbx], edx					;; Set the current number in v to rdx
;; Increment the counteres of v2 and v
	inc		r10
	inc		r11
;; Increment the pointers v2 and v
	add		r14, 4
	add		rbx, 4
;; Move to the next number
	jmp		.loop
;; =========================================================================================================
;; 												End
;; =========================================================================================================