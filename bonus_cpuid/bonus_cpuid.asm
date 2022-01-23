section .text
	global cpu_manufact_id
	global features
	global l2_cache_info


;; =========================================================================================================
;; 	cpu_manufact_id
;; =========================================================================================================
cpu_manufact_id:
;; Create a new stack frame
	enter 	0, 0
;; Save the callee-saved registers
	push	edi
	push	ebx
;; Set edi to the id_string
	mov	edi, dword[ebp + 8]
;; Set eax to 0 and execute cpuid
	mov	eax, 0
	cpuid
;; Fill the id_string
	mov	dword[edi], ebx
	mov	dword[edi + 4], edx
	mov	dword[edi + 8], ecx
;; Restore the callee-saved registers
	pop	ebx
	pop	edi
;; Destroy the current stack frame and return
	leave
	ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================

;; =========================================================================================================
;; 	features:
;; =========================================================================================================
features:
;; Create a new stack frame
	enter 	0, 0
;; Save the callee-saved registers
	push	edi
	push	ebx
;; Set eax to 1 and execute cpuid
	mov	eax, 1
	cpuid


.checkVmx:
;; Check if vmx is available
	mov	ebx, 0x00000020
	and	ebx, ecx
	mov	edi, dword[ebp + 8]
	cmp	ebx, 0
	jne	.setVmx
	mov	dword[edi], 0


.checkRdrand:
;; Check if rdrand is set
	mov	ebx, 0x40000000
	and	ebx, ecx
	mov	edi, dword[ebp + 12]
	cmp	ebx, 0
	jne	.setRdrand
	mov	dword[edi], 0


.checkAvx:
;; Check if avx is set
	mov	ebx, 0x10000000
	and	ebx, ecx
	mov	edi, dword[ebp + 16]
	cmp	ebx, 0
	jne	.setAvx
	mov	dword[edi], 0


.end:
;; Restore the callee-saved registers
	pop	ebx
	pop	edi
;; Destroy the current stack frame and return
	leave
	ret


.setVmx:
	mov	dword[edi], 1
	jmp	.checkRdrand


.setRdrand:
	mov	dword[edi], 1
	jmp	.checkAvx


.setAvx:
	mov	dword[edi], 1
	jmp	.end
;; =========================================================================================================
;; 												End
;; =========================================================================================================


;; =========================================================================================================
;; 	l2_cache_info
;; =========================================================================================================
l2_cache_info:
;; Create a new stack frame
	enter 	0, 0
;; Save the callee-saved registers
	push	edi
	push	ebx
;; Set eax to 0x80000006 and execute cpuid
	mov	eax, 0x80000006
	cpuid
;; Get the line_size
	mov	edi, [ebp + 8]
	movzx	edx, cl
	mov	dword[edi], edx
;; Get the cache_size
	mov	edi, [ebp + 12]
	shr	ecx, 16
	mov	dword[edi], ecx
;; Restore the callee-saved registers
	pop	ebx
	pop	edi
;; Destroy the current stack frame and return
	leave
	ret
;; =========================================================================================================
;; 												End
;; =========================================================================================================
