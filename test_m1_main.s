.equ sp_init 0x70000000

.global _start
_start:
	movia r4, 0x5
	movia r5, 0x6
	movia r6, 0x4
	movia r7, 0x1

	call complex_add
	mov r2, r4

	mov r16, r3

	call print_float

	mov r2, r16

	call print_float

	movia r4, 0x5
	movia r5, 0x6
	movia r6, 0x4
	movia r7, 0x1

	call complex_subtract

	mov r16, r3

	call print_float

	mov r2, r16

	call print_float

	movia r4, 0x5
	movia r5, 0x6
	movia r6, 0x4
	movia r7, 0x1

	call complex_multiply

	mov r16, r3

	call print_float

	mov r2, r16

	call print_float

	movia r4, 0x5
	movia r5, 0x6
	movia r6, 0x4
	movia r7, 0x1

	call complex_divide

	mov r16, r3

	call print_float

	mov r2, r16

	call print_float

	looper:
		br looper

