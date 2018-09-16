
; IOTest.asm 

section .data 	;Iinitialized data

section .bss 	;Uninitialized data
	num resb 1
	eol resb 1

section .text 	;Code Segment
global _start

_start:

	; Read and store the user input
	mov eax, 3
	mov ebx, 0
	mov ecx, num
	mov edx, 2 	;2 bytes of that information
	int 80h

	; Test the input
	cmp byte[num], '@'
je m1

	; Output the number entered
	mov byte [eol], 0xA
	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 2
	int 80h
jmp _start

; Exit code
m1:
	mov eax, 1
	mov ebx, 0
	int 80h