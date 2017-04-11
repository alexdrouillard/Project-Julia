.equ max_red, 31
.equ max_yellow, 63
.equ max_green, 95
.equ max_cyan, 127
.equ max_blue, 159
.equ max_violet, 191
.equ revolution, 192
.equ maxiter, 256
.text
.global hsv_to_rgb

hsv_to_rgb: #hsb_to_rgb(int iterations)
	
	addi sp, sp, -8
	stw r4, 0(sp)
	stw r5, 4(sp)

	movia r5, maxiter
	beq r5, r4, black #if maxiter==iterations, color black

	movia r5, revolution
        blt r4, r5, prime_angle_end
	prime_angle:			#while iterations > revolution:	
		subi r4, r4, revolution #  iterations = iterations-revolution   
		bgt r4, r5, prime_angle
        prime_angle_end:        
	
	movia r5, max_red
	ble r4, r5, red		#if iterations < 31, goto red

	movia r5, max_yellow
	ble r4, r5, yellow	#elif iterations < 63, goto yellow
	
	movia r5, max_green
	ble r4, r5, green	#elif iterations < 95, goto green
		
	movia r5, max_cyan
	ble r4, r5, cyan	#elif iterations < 127, goto cyan	

	movia r5, max_blue
	ble r4, r5, blue	#elif iterations < 159, goto blue
	
	movia r5, max_violet
	ble r4, r5, violet	#elif iterations < 192, goto violet
	red:
		movia r2, 0xF800 # 11111 000000 00000
		slli r4, r4, 6
		or r2, r2, r4
		br hsb_end
	yellow:
		movia r2, 0x07E0 # 00000 111111	00000
		movia r5, 31
		sub r4, r5, r4   # r4 = 31 - r4
		slli r4, r4, 11
		or r2, r2, r4
		br hsb_end		
	green:
		movia r2, 0x07E0 # 00000 111111 00000
		or r2, r2, r4
		br hsb_end
	cyan:
		movia r2, 0x001F # 00000 000000 11111
		movia r5, 31
		sub r4, r5, r4   # r4 = 31 - r4
                andi r4, r4, 0x001F 
		slli r4, r4, 6   #shift all the way to the left
		or r2, r2, r4
		br hsb_end
	blue:
		movia r2, 0x001F # 00000 000000 11111
		slli r4, r4, 11
		or r2, r2, r4	
		br hsb_end
	violet:
		movia r2, 0xF800 # 11111 000000 00000
		movia r5, 31
		sub r4, r5, r4 #r4 = 31 - r4
                andi r4, r4, 0x001F
		or r2, r2, r4
		br hsb_end
	black:
		mov r2, r0  # return 0 (black)
	hsb_end:
	
	ldw r4, 0(sp)
	ldw r5, 4(sp)
	addi sp, sp, 8

	ret
