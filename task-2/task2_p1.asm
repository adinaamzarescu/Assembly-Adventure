section .text
	global cmmmc

;; =========================================================================================================
;;  cmmmc
;; =========================================================================================================
cmmmc:
;; Create a new stack frame
	push    ebp
	push 	esp
	pop 	ebp
;; Save the callee-saved registers
	push	dword[ebp + 8]
	pop		eax						;; Set eax to the first argument
	push 	dword[ebp + 12]
	pop 	ebx						;; Set ebx to the second argument
;; Save the 2 numbers
	push 	eax
	push 	ebx

;; Loop until the greatest common factor is found
.while:
;; Compare the two numbers
	cmp 	eax, ebx
;; If a = b
	je		.cmmmdcFound
;; If b > a
	jg		.caseOne
;; If a > b
	jl		.caseTwo

.caseOne:
	;; b = b - a
	sub 	eax, ebx
	jmp 	.while

.caseTwo:
	;; a = a - b
	sub 	ebx, eax
	jmp 	.while

.cmmmdcFound:
;; Save the greatest common factor in ecx
	push 	eax
	pop 	ecx
;; Restore the initial two numbers a and b
	pop 	eax
	pop 	ebx
;; Multiply the two numbers a and b
	mul 	ebx
;; The result will be stored in eax, eax = a * b
	push 	eax
;; Save the result of the miltiplication in edx
	pop 	edx
;; Save the  greatest common factor in eax
	push 	ecx
	pop 	eax
;; Make edi = 0 in order to store the result
	xor 	edi, edi

;; Divide the result of the multiplication by
;; the greatest common factor
.divide:
;; Use multiple substractions to divide
	sub 	edx, eax
;; Increment the counter
	inc 	edi
;; Compare the result of the substraction
	cmp 	edx, 0
	jg 		.divide
	je 		.end

.end:
;; Save the least common multiple in eax
	push 	edi
	pop 	eax
;; Restore the base pointer and return
	leave
	ret
;; =========================================================================================================
;; 										End
;; =============================================================================================================
