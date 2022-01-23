global get_words
global compare_func
global sort

extern qsort

section .text

;; =========================================================================================================
;;  sort
;; =========================================================================================================
sort:
;; Create a new stack frame
    enter 0, 0
;; Set the argument of the qsort function
	push	compare_func
	push	dword[ebp + 16]
	push	dword[ebp + 12]
	push	dword[ebp + 8]
;; Call qsort
	call	qsort
;; Restore the stack
	add		esp, 16


.end:
;; Destroy the current stack frame
    leave
    ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================


;; =========================================================================================================
;; 	compare_func
;; =========================================================================================================
compare_func:
;; Create a new stack frame
	enter 0, 0
;; Save the calle-saved registers
	push	ebx
	push	edi
	push	esi
;; Set edi to the first string s1
	mov		edi, dword[ebp + 8]
	mov		edi, dword[edi]
;; Set esi to the second string s2
	mov		esi, dword[ebp + 12]
	mov		esi, dword[esi]
;; Get the length of the second string s2
	;; Push the argument of ft_strlen on the stack
	push	esi
	;; Call ft_strlen
	call	ft_strlen
	;; Restore the stack
	add		esp, 4
	;; Save the return value in ebx
	mov		ebx, eax
;; Get the length of the first string s1
	;; Push the argument of ft_strlen on the stack
	push	edi
	;; Call ft_strlen
	call	ft_strlen
	;; Restore the stack
	add		esp, 4
;; Set eax to s1.length - s2.length
	sub		eax, ebx
;; Check if the length of the two strings is different
	cmp		eax, 0
	jne		.end
;; Check the lexicographical order of the two strings s1 and s2
	;; Push the arguments of ft_strcmp to the stack
	push	esi							;; Set the second argument of ft_strcmp to s2
	push	edi							;; Set the first argument of ft_strcmp to s1
	;; Call ft_strcmp
	call	ft_strcmp
	;; Restore the stack
	add		esp, 8


.end:
;; Restore the callee-saved registers
	pop		esi
	pop		edi
	pop		ebx
;; Destroys the current stack frame
    leave
    ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================


;; =========================================================================================================
;; 	ft_strlen
;; =========================================================================================================
;; size_t	ft_strlen(const char *s)
ft_strlen:
;; Create a new stack frame
	enter 0, 0
;; Save the calle-saved registers
	push	edi
;; Set edi to the agrument s
	mov		edi, dword[ebp + 8]
;; Set the return value eax to 0
	mov		eax, 0


.loop:
	movzx	edx, byte[edi + eax]
	cmp		edx, 0
	je		.end
	inc		eax
	jmp		.loop


.end:
;; Restore the callee-saved registers
	pop		edi
;; Destroys the current stack frame
    leave
    ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================


;; =========================================================================================================
;; 	ft_strcmp
;; =========================================================================================================
ft_strcmp:
;; Create a new stack frame
	enter 0, 0
;; Save the calle-saved registers
	push	edi
	push	esi
;; Set the counter ecx to 0
	mov		ecx, 0
;; Set edi to the first agrument s1
	mov		edi, dword[ebp + 8]
;; Set esi to the second argument s2
	mov		esi, dword[ebp + 12]


.loop:
;; Set eax to the current character in s1
	movzx	eax, byte[edi + ecx]
;; Set edx to the current characeter in s2
	movzx	edx, byte[esi + ecx]
;; Check if the current characeters of each string are different
	cmp		eax, edx
	jne		.end
;; Check if the end of the first string s1 is reached
	cmp		eax, 0
	je		.end
;; Increment the counter ecx
	inc		ecx
	jmp		.loop


.end:
;; Set eax = eax - edx
	sub		eax, edx
;; Restore the callee-saved registers
	pop		esi
	pop		edi
;; Destroys the current stack frame
    leave
    ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================


;; =========================================================================================================
;; 	get_words
;; =========================================================================================================
get_words:
;; Create a new stack frame
    enter 0, 0
;; Save the calle-saved registers
	push	ebx
	push	edi
	push	esi
;; Initialise the necessary registers
	mov		ebx, dword[ebp + 8]				;; Set ebx to the first argument s
	mov		edi, dword[ebp + 12]			;; Set edi to the second argument words
	mov		edi, dword[edi]					;; Set edi to the first word : words[0]
	mov		esi, 0							;; Set esi to the index of the current word
	mov		ecx, -1							;; Set ecx the counter of the string s to -1


.extractWord:
;; Check if the number of parsed words exceeds the number_of_words
	cmp		esi, dword[ebp + 16]
	jge		.end
;; Set eax the counter of the current word to -1
	mov		eax, -1


;; Loop over and split the string s with the delimiters " ,.\n"
.loop:
;; Increment the counters ecx and eax
	inc		ecx
	inc		eax
;; Set edx to the current character
	movzx	edx, byte[ebx + ecx]
;; Check if the current character is a delimiter
	cmp		edx, 0						;; Check if the current character is '\0'
	je		.handleEndWord
	cmp		edx, 32						;; Check if the current character is ' '
	je		.handleEndWord
	cmp		edx, 44						;; Check if the current character is ','
	je		.handleEndWord
	cmp		edx, 46						;; Check if the current character is '.'
	je		.handleEndWord
	cmp		edx, 10						;; Check if the current character is '\n'
	je		.handleEndWord
;; Update the current word
	mov		byte[edi + eax], dl
;; Move to the next character
	jmp		.loop


.end:
;; Restore the callee-saved registers
	pop		esi
	pop		edi
	pop		ebx
;; Destroys the current stack frame
    leave
    ret


.handleEndWord:
;; Set the current character to '\0'
	mov		byte[edi + eax], 0
;; Check if the end of the string s is reached
	cmp		edx, 0
	je		.end
;; Check if the current word is empty
	cmp		eax, 0
	je		.extractWord
;; Move to the next word
	;; Increment the number of parsed words
	inc		esi
	;; word = words[esi]
	mov		edi, dword[ebp + 12]			;; Set edi to the second argument words
	mov		eax, 4							;; Set eax to 4
	mul		esi								;; Set eax = esi * 4
	mov		edi, dword[edi + eax]			;; Set edi to the first word words[ecx]
	jmp		.extractWord
;; =========================================================================================================
;; 												End
;; =========================================================================================================