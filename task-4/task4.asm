section .text

global expression
global term
global factor


;; =========================================================================================================
;;  factor
;; =========================================================================================================
factor:
;; Save the base pointer register
	push    ebp
	mov     ebp, esp
;; Save the ebx, edi, and esi registers
	push	ebx
	push	edi
	push	esi
;; Initialise the needed registers
	mov	edi, dword[ebp + 8]				;; Initialise edi to the first parameter p
	mov	ebx, dword[ebp + 12]		        	;; Set ebx to the second parametr i
	mov	ecx, dword[ebx]					;; Intialise ecx to the current index
;; Check if the current character is a digit
	movzx	esi, byte[edi + ecx]		                ;; Load the current character
	cmp	esi, 48
	jl	.getNextExpression
	cmp	esi, 57
	jg	.getNextExpression


.parseNumber:
;; Intialise the return value to 0
	mov	eax, 0
;; Intialise ebx to 10 to speed the calculation
	mov	ebx, 10


.loop:
;; Load the current character
	movzx	esi, byte[edi + ecx]
;; Check if an non digit is encountered
	cmp	esi, 48
	jl	.loopEnd
	cmp	esi, 57
	jg	.loopEnd
;; eax = eax * 10 + ['current digit' - '0']
	mul	ebx
	sub	esi, 48
	add	eax, esi
;; Increment the index counter ecx and loop over
	inc	ecx
	jmp	.loop


.loopEnd:
;; Update the index i
	mov	ebx, dword[ebp + 12]		        	;; Set ebx to the second parametr i
	mov	[ebx], ecx
	jmp	.end


.getNextExpression:
;; Update the index i
	inc	ecx
	mov	[ebx], ecx
;; Push the parameters of expression on the stack
	push	ebx						;; Push the second parameter i
	push	edi						;; Push the first parameter p
;; Call expression
	call	expression
;; Restore the stack
	add	esp, 8


.end:
;; Restore the ebx, edi, and esi registers
	pop	esi
	pop	edi
	pop	ebx
;; Restore the base pointer and return
	leave
	ret
;; =========================================================================================================
;; 						End
;; =========================================================================================================

;; =========================================================================================================
;; 	term
;; =========================================================================================================
term:
;; Save the base pointer register
	push    ebp
	mov     ebp, esp
;; Allocate two variables on the stack
	push	1						        ;; To hold the return value, 1 by default
	push	42							;; To hold the current operand, * by default
;; Save the ebx, edi, and esi registers
	push	ebx
	push	edi
	push	esi
;; Initialise the needed registers
	mov	edi, dword[ebp + 8]			        	;; Initialise edi to the first parameter p
	mov	ebx, dword[ebp + 12]		                	;; Initialise ebx to the second parametr i
	mov	ecx, dword[ebx]				        	;; Intialise ecx to the current index
;; Push the parameters of the factor function to the stack
	push	ebx							;; Push the second parameter i to the stack
	push	edi							;; Push the first parameter p to the stack
	

.loop:
;; Set esi to the current chatacter
	movzx	esi, byte[edi + ecx]
;; Check if the end of p is reached
	cmp	esi, 0
	je	.loopEnd
;; Call factor : the parameters are already pushed on the stack before the loop to speed things up
	call	factor
;; Update the return value
	mov	ecx, eax						;; Save the return value in ecx
	mov	eax, dword[ebp - 4]			        	;; Get the return value from the stack
	mov	esi, dword[ebp - 8]			        	;; Set esi to the active operand
	;; Choose the operation to execute
	cmp	esi, 47							;; Check if the operand is '/'
	je	.divide


.multiply:
;; Update the return value
	imul	ecx
	mov	[ebp - 4], eax


.checkOperand:
;; Update the operand
	mov	ecx, dword[ebx]						;; Get the current index
	movzx	esi, byte[edi + ecx]					;; Get the current character
	mov	[ebp - 8], esi						;; Set the operand to the current character
;; Check if the operand is * or /
	cmp	esi, 42
	je	.loopContinue
	cmp	esi, 47
	je	.loopContinue


.loopEnd:
;; Get the factor parameters out of the stack
	add	esp, 8


.end:
;; Restore the ebx, edi, and esi registers
	pop	esi
	pop	edi
	pop	ebx
;; Set eax to the return value
	mov	eax, dword[ebp - 4]
;; Deallocate the local variables
	add	esp, 8
;; Restore the base pointer and return
	leave
	ret


.divide:
;; Update the return value
	cdq								;; Sign extend eax to edx
	idiv	ecx
	mov	[ebp - 4], eax
;; Continue to the rest of the loop
	jmp	.checkOperand


.loopContinue:
;; Increase the index
	inc	ecx
	mov	[ebx], ecx
	jmp	.loop
;; =========================================================================================================
;; 						End
;; =========================================================================================================


;; =========================================================================================================
;; 	Expression
;; =========================================================================================================
expression:
;; Save the base pointer register
	push    ebp
	mov     ebp, esp
;; Allocate two variables on the stack
	push	0							;; To hold the return value, 0 by default
	push	43							;; To hold the current operand, + by default
;; Save the ebx, edi, and esi registers
	push	ebx
	push	edi
	push	esi
;; Initialise the needed registers
	mov	edi, dword[ebp + 8]			        	;; Initialise edi to the first parameter p
	mov	ebx, dword[ebp + 12]		        		;; Initialise ebx to the second parametr i
	mov	ecx, dword[ebx]				        	;; Initialise ecx to the current index
;; Push the parameters of the term function to the stack
	push	ebx							;; Push the second parameter i to the stack
	push	edi							;; Push the first parameter p to the stack
	

.loop:
;; Set esi to the current chatacter
	movzx	esi, byte[edi + ecx]
;; Check if the end of p is reached
	cmp	esi, 0
	je	.loopEnd
;; Call term : the parameters are already pushed on the stack before the loop to speed things up
	call	term
;; Update the return value
	mov	ecx, eax						;; Save the return value in ecx
	mov	eax, dword[ebp - 4]			        	;; Get the return value from the stack
	mov	esi, dword[ebp - 8]			        	;; Set esi to the active operand
	;; Choose the operation to execute
	cmp	esi, 45
	je	.ft_subtract


.ft_add:
;; Update the return value
	add	eax, ecx
	mov	[ebp - 4], eax


.checkOperand:
;; Update the operand
	mov	ecx, dword[ebx]				       		;; Get the current index
	movzx	esi, byte[edi + ecx]		       			;; Get the current character
	mov	[ebp - 8], esi				       		;; Set the operand to the current character
;; Check if the operand is + or -
	cmp	esi, 43
	je	.loopContinue
	cmp	esi, 45
	je	.loopContinue
;; Check if the end of the expression ) is reached
	cmp	esi, 41
	je	.handleEndExpression


.loopEnd:
;; Get the term parameters out of the stack
	add	esp, 8


.end:
;; Restore the ebx, edi, and esi registers
	pop	esi
	pop	edi
	pop	ebx
;; Set eax to the return value
	mov	eax, dword[ebp - 4]
;; Deallocate the local variables
	add	esp, 8
;; Restore the base pointer and return
	leave
	ret


.ft_subtract:
;; Update the return value
	sub	eax, ecx
	mov	[ebp - 4], eax
;; Continue to the rest of the loop
	jmp	.checkOperand


.loopContinue:
;; Increase the index
	inc	ecx
	mov	[ebx], ecx
	jmp	.loop


.handleEndExpression:
;; Increase the index
	inc	ecx
	mov	[ebx], ecx
	jmp	.loopEnd
;; =========================================================================================================
;; 						End
;; =========================================================================================================
