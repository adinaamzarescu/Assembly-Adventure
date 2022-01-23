section .text
	global sort
;; =========================================================================================================
;;  sort
;; =========================================================================================================
sort:
;; Create a new stack frame
	enter 	0, 0
;; Initialise the needed registers
	mov     ecx, [ebp + 8]  			;;  Initialise ecx to the first parameter n
    mov     esi, [ebp + 12] 			;;  Initialise edi to the second parameter nodes
;; Since the sort will be made from 0 to n - 1
	dec 	ecx
;; If there is only one node, end
	cmp 	ecx, 0
	jl 		.end
.while1:
;; Copy the number of values, n
	mov 	eax, [ebp + 8]
;; Since the sort will be made from 0 to n - 1
	dec 	eax
;; Find the min node in order to return it
	cmp 	dword[esi + ecx * 8], 1
;; If found, save it
	je 		.save
;; If not, keep searching
	jne 	.search
.save:
;; Save the eax since the multiplication will be saved here
	push 	eax
;; Multiplicate the current number of values by 8
	mov 	edx, 8
	mov 	eax, ecx
	mul 	edx
;; Make eax point to the value
	add 	eax, esi
;; Store the result in edx
	mov 	edx, eax
;; Restore the eax value
	pop 	eax
;; Save the result
	push 	edx
.search:
;; If ecx is 0 then the program will end 
	cmp 	ecx, 0
	jl 		.end
.while2:
;; If eax is 0, sort the values
	cmp 	eax, 0
	jl 		.decrement
	jge 	.selectionSort
.selectionSort:
;; Store the value in edx
	xor		edx, edx 
	mov 	edx, [esi + ecx * 8]
;; Increment edx to get the next value
	inc 	edx
;; Compare it to the previous value
	cmp 	edx, [esi + eax * 8]
;; If they are equal, link them
	je 		.link
;; Decrement eax and go back to the second while
	dec 	eax
	jmp 	.while2
.link:
;; Multiply eax by 8
	xor 	edx, edx
	mov 	edx, 8
	mul 	edx
;; Make eax point to the value
	add 	eax, esi
;; Link the next of the previous node
	mov 	[esi + ecx * 8 + 4], eax
.decrement:
;; Decrement ecx
	dec 	ecx
	jmp 	.while1
.end:
;; Save everything in eax
	pop 	eax
;; Destroy the current stack frame
	leave
	ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================
