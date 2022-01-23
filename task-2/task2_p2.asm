section .text
	global par

;; =========================================================================================================
;;  par
;; =========================================================================================================
par:
;; Create a new stack frame
	push    ebp
	push	esp
	pop	ebp
;; Save the string str in eax
	push 	dword [ebp + 12]
	pop 	eax
;; Store the number of '(' in ebx
	xor 	ebx, ebx
;; Store the number of ')' in ecx
	xor 	ecx, ecx
;; Loop strlen(str) times
	cmp 	dword [ebp + 8], 0
	jg 	.while
.while:
;; Check if the string ended
	cmp 	dword [ebp + 8], 0
;; If strlen(str) = 0 stop
	jle 	.stop
;; Compare the first bracket with '('
	cmp 	byte [eax], 40
;; Increment the number of open brackets
	je 	.increment_open
;; Compare the first bracket with ')'
	cmp 	byte [eax], 41
;; Increment the number of closed brackets
	je 	.increment_closed

.increment_open:
	inc 	ebx
	jmp 	.check

.increment_closed:
	inc 	ecx
	jmp 	.check

.check:
;; Decrement the number of characters in str
	dec 	dword [ebp + 8]
;; Move the pointer to the next character of the string
	inc 	eax
	jmp 	.while

.stop:
;; The string has ended
	xor 	eax, eax
;; Compare the number of open and closed brackets 
	cmp 	ebx, ecx
	je 	.equal
	jmp 	.not_equal
.equal:
;; If ebx = ecx the brackets are balanced 
	add 	eax, 1
.not_equal:
;; If ebx != ecx the brackets are not balanced
;; The eax register is already 0
.end:
	leave
	ret
;; =========================================================================================================
;; 										End
;; =============================================================================================================
