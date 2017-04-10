.equ keyboard_address, 0xFF200100

.global keyboard_input

#int keyboard_input() gets rid of bounce and just reads one value
keyboard_input:
	movia r4, keyboard_address
	ldwio r2, 0(r4) #grab all the keyboard info
	movia r6, 0x0080
	and r7, r2, r6
	bne r7, r6, keyboard_input
	ret
read_valid:
	addi sp, sp, -4
	stw ra, 0(sp)

	call keyboard_input
	andi r4, r2, 0xFF #put data on r4
	beq r4, 0xE0, read_extra_char
	br read_next
	read_extra_char:
		call keyboard_input
		andi r4, r2, 0xFF
	read_next:
		call keyboard_input
	andi r2, r2, 0xFF
	

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

 
		

	
	
