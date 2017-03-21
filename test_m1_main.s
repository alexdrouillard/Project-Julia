.equ sp_init, 0x70000000

.global main
main:
	movia r4, 0x40a00000 	
	movia r5, 0x40a00000
	movia r6, 0x40a00000
	movia r7, 0x40a00000

	movia sp, sp_init
	
	call complex_add
	mov r4, r2
	addi sp, sp, -4
	stw r3, 0(sp)

	call print_float

	ldw r4, 0(sp)
	addi sp, sp, 4 

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

