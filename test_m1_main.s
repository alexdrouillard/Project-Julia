.equ sp_init, 0x017FFF80
.equ left, 0xC0C00000 #-6.0
.equ right, 0x40C00000 #6.0
.equ top, 0x40800000 #4.0 GPA sad bois
.equ bot, 0xC0800000 #-4.0 
.equ width, 0x43A00000 #320.0 in hex
.equ height, 0x43700000 #240.0 in hex

.global main
main:
	movia sp, sp_init
	movi r4, 0
	movi r5, 0

	call iterate
	mov r4, r2
	mov r5, r3
	call print_int

	movia r4, 0x40000000
	movia r5, 0x40000000

	call iterate
	mov r4, r2
	mov r5, r3
	call print_int

    #want to write blue to a bunch of pixels
   	mov r7, r0
	movi r7, 320
	draw_rainbow: 
		mov r4, r7
		call hsv_to_rgb
		mov   r6, r2 
		movui r4, 100
   		movui r5, 100
		addi r7, r7, 1
 	   	call draw_pixel
		addi r4, r4, 1
		bne r4, r7, draw_rainbow  
looper:
	br looper
