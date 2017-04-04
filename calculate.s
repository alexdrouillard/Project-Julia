#unisigned int iterate(complex_num r4-r5)
#complex_num equation(complex_num r4-r5)

.equ maxiter, 256
.equ threshold, 0x41200000
.global iterate
iterate:
	addi sp, sp, -32
	stw  r16, 0(sp)
	stw  r17, 4(sp)
	stw  r18, 8(sp)
	stw  r4,  12(sp)
	stw  r5,  16(sp)
    stw  ra,  20(sp)

	movia r17, maxiter
	movia r18, threshold
	movia r16, 0

	iterate_loop:
		beq r17, r16, iterate_loop_done
		call complex_magnitude
		bgt r2, r18, iterate_loop_done
		call equation
		mov  r4, r2
		mov  r5, r3
        addi r16, r16, 1
		br iterate_loop
	iterate_loop_done:

	mov r2, r16
    
    ldw  ra,  20(sp)
	ldw  r5,  16(sp)
	ldw  r4,  12(sp)
	ldw  r18, 8(sp)
	ldw  r17, 4(sp)
	ldw  r16, 0(sp)
	addi sp, sp, 32
	ret


equation:
	addi sp, sp, -12
	stw  ra, 0(sp)
	stw  r4, 4(sp)
	stw  r5, 8(sp)

	mov  r6, r4
	mov  r7, r5
	call complex_multiply

	movia r4, 0xbf4ccccd
	movia r5, 0x3e1fbe77

	mov r6, r2
	mov r7, r3

	call complex_add

	ldw  r5, 8(sp)
	ldw  r4, 4(sp)
	ldw  ra, 0(sp)
	addi sp, sp, 12
	ret
