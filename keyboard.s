.equ keyboard_address, 0xFF200100
.text
.global read_valid
.global keyboard_input

#int keyboard_input() gets rid of bounce and just reads one value
keyboard_input:
        addi sp, sp, -16

        stw r4, 12(sp)
        stw r5, 8(sp)
        stw r6, 4(sp)
        stw r7, 0(sp)
        keyboard_input_looper:

	movia r4, keyboard_address
	ldwio r2, 0(r4) #grab all the keyboard info
	movia r6, 0x008000
	and r7, r2, r6
	bne r7, r6, keyboard_input_looper
        
        ldw r4, 12(sp)
        ldw r5, 8(sp)
        ldw r6, 4(sp)
        ldw r7, 0(sp)
        addi sp, sp, 16
	ret
read_valid:
	addi sp, sp, -12
	stw ra, 0(sp)
        stw r4, 4(sp)
        stw r5, 8(sp)
        
        read_next:
	call keyboard_input
	andi r3, r2, 0xFF #put data on r4
        movia r5, 0xF0
	beq r5, r3, ignore_next
        movia r5, 0xE0
        beq r5, r3, read_next
        mov r2, r3
        
        ldw ra, 0(sp)
        ldw r4, 4(sp)
        ldw r5, 8(sp)
        addi sp, sp, 12
        ret

        ignore_next:
            call keyboard_input
            br read_next
        


 
		

	
	
