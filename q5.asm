; IOcalc.asm

section .data 	;line 1
	msg db "Sum is: "
	len equ $ - msg
	eol db 0xA, 0xD
	eol_len equ $ - eol

section .bss
	sum resb 8

section .text
global _start

print_int:
	mov eax, 4 	;defining routine print_int
	mov ebx, 1	;file descriptor (stdout)
	int 0x80	;system call number (sys_write)
	ret		;return back

_start:	 		;line 19
	mov eax, 3h
	sub eax, '0'
	mov ebx, 4h
	sub ebx, '0'
	add eax, ebx
	add eax, '0'

	mov [sum], eax

	mov ecx, msg
	mov edx, len
	call print_int

	mov ecx, sum
	mov edx, 2
	call print_int

	mov ecx, eol
	mov edx, eol_len
	call print_int

	mov eax, 1 	;system call number (sys_exit)
	xor ebx, ebx
	int 0x80 	;line 43