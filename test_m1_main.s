.equ sp_init, 0x70000000

.global main
main:
	movia sp, 0x70000000
	movi r4, 0
	movi r5, 0

	call iterate
	mov r4, r2
	mov r5, r3
	call print_complex

	movia r4, 0x40000000
	movia r4, 0x40000000

	call iterate
	mov r4, r2
	mov r5, r3
	call print_complex
looper:
	br looper
