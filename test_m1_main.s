.equ sp_init, 0x017FFF80

.global main
main:
	movia sp, sp_init
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

        #want to write blue to a bunch of pixels
        movui r4, 10
        movui r5, 100
        movui r6, 0x000F

        call draw_pixel  
looper:
	br looper
