#unisigned int iterate(complex_num r4-r5)
#complex_num equation(complex_num r4-r5)

.equ maxiter, 256
.equ threshold, 0x41200000
.global iterate
iterate:
	addi sp, sp, -32
        stw  ra,  20(sp)

	movia r12, maxiter
	movia r13, threshold
	movia r11, 0

	iterate_loop:
		beq r12, r11, iterate_loop_done
		call complex_magnitude
		bgt r2, r13, iterate_loop_done

                # CALCULATE
                mov  r6, r4
                mov  r7, r5
                call complex_multiply

                movia r4, 0xbf4ccccd
                movia r5, 0x3e1fbe77

                mov r6, r2
                mov r7, r3

                call complex_add

                #calculate
		mov  r4, r2
		mov  r5, r3
                addi r11, r11, 1
		br iterate_loop
	iterate_loop_done:

	mov r2, r11
        
        ldw ra, 20(sp) 
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
