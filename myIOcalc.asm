; File: myIOcalc.asm
; CMSC 313 - Spring 2018 - Project 2 - I/O and simple arithmetic
; Innocent Kironji
; wambugu1@umbc.edu

section .data 	
	msg db "Sum is: "
	len equ $ - msg
	prompt1 db "Enter two numbers to add (press enter after each number): "
	p1_len equ $ - prompt1
	eol db 0xA, 0xD
	eol_len equ $ - eol

section .bss
	sum resb 8
	num1 resb 4
	num2 resb 4

section .text
global _start

print_int:
	mov eax, 4 	;defining routine print_int
	mov ebx, 1	;file descriptor (stdout)
	int 0x80	;system call number (sys_write)
	ret		;return back
	
_start:
	; Display Prompt for first number
	mov eax, 4             ;system call number (sys_write)
	mov ebx, 1             ;first argument: file handle (stdout)
	mov ecx, prompt1       ;second argument: pointer to message to write
	mov edx, p1_len        ;third argument: message length
	int 0x80               ;call kernel and exit

	; Read and store the user input
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 4 		;4 bytes of that information
	int 80h

	; Read and store the user's second  input
	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 4 		;4 bytes of that information
	int 80h

	; Adding the numbers and outputting them
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	
	mov [sum], eax

	mov ecx, msg
	mov edx, len
	call print_int

	mov ecx, sum
	mov edx, 5
	call print_int

	mov ecx, eol
	mov edx, eol_len
	call print_int

	mov eax, 1 	;system call number (sys_exit)
	xor ebx, ebx
	int 0x80 