.data
.align 2
box_x: .word 80
box_y: .word 60
left_box: .store 118
right_box: .store 118
top_box: .store 160
bot_box: .store 160

.equ VGA_ADDR, 0x08000000
.equ X_COORD_MAX, 320
.equ Y_COORD_MAX, 240
.equ BOX_WIDTH_FLOAT, 0x43200000
.equ BOX_HEIGHT_FLOAT, 0x42f00000

.data
    right: .word 0x40000000 #2.0
    left: .word 0xC0000000 #-2.0
    bot: .word 0x3f800000 #-1.0 GPA sad bois
    top: .word 0xbf800000 #1.0 
    width: .word 0x43A00000 #320.0 in hex
    height: .word 0x43700000 #240.0 in hex

.equ float_one, 0x3f800000
.equ float_320, 0x43a00000
.equ float_240, 0x43700000

.global draw_pixel
# r4 = x
# r5 = y
# r6 = color

draw_box:
	#r4 = top_left of box x pixel
	#r5 = top_left of box y pixel
		

draw_and_save_pixel:
	#r4 = xpixel
	#r5 = ypixel
	#r6 = memory address
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call save_pixel
	movia r6, 0xFFFF # draw white into pixel
	call save_pixel
	stw ra, 0(sp)

	addi sp, sp, 4
	ret

save_pixel:
	#r4 = xpixel
	#r5 = ypixel
        #r6 = memory_address
        #no retrurn value
	
    addi sp, sp, -20
    stw r4, 0(sp) 
    stw r5, 4(sp) 
    stw r6, 8(sp)  
    stw r8, 12(sp)
    stw ra, 16(sp) 
    
    #use r8 for the pixel address 
    mov r8, r0
    movia r8, VGA_ADDR
    slli r5, r5, 10
    or r8, r8, r5
    slli r4, r4, 1
    or r8, r8, r4
    ldhio r5, 0(r8)
    sth r5, 0(r6)    

    ldw r4, 0(sp) 
    ldw r5, 4(sp) 
    ldw r6, 8(sp)  
    ldw r8, 12(sp)
    ldw ra, 16(sp) 
    
    addi sp, sp, 20
 
    ret 
	
save_lines:
	#r4 = top_left x pixel
	#r5 = top_left y pixel
	addi sp, sp, -4
	stw ra, 0(sp)
	movia r7, 160
	movia r6, top_box
	save_top:
		call save_pixel
		subi r7, r7, 1
		addi r6, r6, 2
		bne r7, r0, save_top 
	
	call save_line
	call save_line
	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

	


draw_pixel: 
    addi sp, sp, -20
    stw r4, 0(sp) 
    stw r5, 4(sp) 
    stw r6, 8(sp)  
    stw r8, 12(sp)
    stw ra, 16(sp) 
    
    #use r8 for the pixel address 
    mov r8, r0
    movia r8, VGA_ADDR
    slli r5, r5, 10
    or r8, r8, r5
    slli r4, r4, 1
    or r8, r8, r4
    sthio r6, 0(r8)
    
    ldw r4, 0(sp) 
    ldw r5, 4(sp) 
    ldw r6, 8(sp)  
    ldw r8, 12(sp)
    ldw ra, 16(sp) 
    
    addi sp, sp, 20
 
    ret 

.global draw_set
draw_set: 
    addi sp, sp, -88
    stw r4, 0(sp) 
    stw r5, 4(sp) 
    stw r6, 8(sp) 
    stw r7, 12(sp) 
    stw r8, 16(sp) 
    stw r9, 20(sp) 
    stw r10, 24(sp) 
    stw r11, 28(sp) 
    stw r12, 32(sp) 
    stw r13, 36(sp) 
    stw r14, 40(sp) 
    stw r15, 44(sp) 
    stw r16, 48(sp) 
    stw r17, 52(sp) 
    stw r18, 56(sp) 
    stw r19, 60(sp) 
    stw r20, 64(sp) 
    stw r21, 68(sp) 
    stw r22, 72(sp) 
    stw r23, 76(sp) 
    stw ra, 80(sp) 

    # screen coordinates start at 0,0

    call int_to_float #convert r4 into a float
    mov r4, r2
    stw r4, 84(sp)

    ldw r5, 4(sp)
    mov r4, r5     
    call int_to_float
    mov r5, r2
    ldw r4, 84(sp)


    mov r10, r0    # at this point, r4 and r5 are float values

calculate_constants:
    movia r14, left
    ldw r14, 0(r14)
    movia r15, top
    ldw r15, 0(r15)

    calculate_x_constant:
        movia r16, left
        movia r17, right
        ldw r16, 0(r16)
        ldw r17, 0(r17)
 
        #right - left
        custom 254, r2, r17, r16

        movia r6, width
        ldw r6, 0(r6)

        custom 255, r20, r2, r6 # r20 holds (right - left)/width

    calculate_y_constant:
        movia r16, top
        movia r17, bot
        ldw r16, 0(r16)
        ldw r17, 0(r17)

        # bot - top
        custom 254, r2, r17, r16
        movia r6, height
        ldw r6, 0(r6)

        custom 255, r21, r2, r6 # r21 holds (bot - top)/height

    # compute new constants here
    # first, compute where in cartesian where the given pixel is
    # to calculate left and right, need to find cartesian of new left and right
    # find new left
    bne r10, r0, skip_new_constants
    compute_new_constants:

        compute_new_left:
             # do input_pixel * xconstant 
            custom 252, r14, r4, r20      
        
            movia r15, left
            ldw r15, 0(r15)
            # do left + input_pixel*xconstant
            custom 253, r15, r15, r14
            movia r14, left
            # store new left
            stw r15, 0(r14)
        compute_new_right:
            movia r6, BOX_WIDTH_FLOAT 
            custom 253, r6, r4, r6 
            # r6 now holds the pixel value of the rightmost corner
            # do (input_pixel + box_width)*constant
            custom 252, r14, r6, r20
            movia r15, left
            ldw r15, 0(r15)
            # do left + (input_pixel + box_width)*constant 
            custom 253, r14, r15, r14 
            # now need to store that result into right
            movia r15, right
            stw r14, 0(r15)
        compute_new_top:
             # do input_pixel * yconstant 
            custom 252, r14, r5, r21      
        
            movia r15, top
            ldw r15, 0(r15)
            # do top + input_pixel*yconstant
            custom 253, r15, r15, r14
            movia r14, top
            # store new top
            stw r15, 0(r14)
        compute_new_bottom:
            
            movia r6, BOX_HEIGHT_FLOAT 
            custom 253, r6, r5, r6 
            # r6 now holds the pixel value of the bottom
            # do (input_pixel + box_width)*constant
            custom 252, r14, r6, r21
            movia r15, top
            ldw r15, 0(r15)
            # do left + (input_pixel + box_width)*constant 
            custom 253, r14, r15, r14 
            # now need to store that result into right
            movia r15, bot
            stw r14, 0(r15)
        done_constants:
            movia r10, 0x01
    br calculate_constants
    skip_new_constants:    




    mov r16, r0 #screen_x
    mov r17, r0 #screen_y

    mov r8, r0 #screen_x_float
    mov r9, r0 #screen_y_float
    movia r10, float_one  

    movia r18, X_COORD_MAX
    movia r19, Y_COORD_MAX

    draw_x:
    beq r16, r18, draw_x_done
    mov r17, r0
    # do x * xconstant
    custom 252, r22, r8, r20 
    # do left + x*xconstant

    custom 253, r22, r14, r22
    mov r9, r0

        draw_y:
        beq r17, r19, draw_y_done
        
        # xconstant = r20
        # yconstant = r21
        # x = r16
        # y = r17 

        # do y * yconstant

        custom 252, r23, r9, r21

        # do top + y*yconstant

        custom 253, r23, r15, r23

        #now get the julia set value for x and y
        mov r4, r22
        mov r5, r23
        call iterate
        # r2 holds julia number
        mov r4, r2
        call hsv_to_rgb
        # r2 holds rgb value
        mov r4, r16 # x
        mov r5, r17 # y
        mov r6, r2 # color

        call draw_pixel             
        
        addi r17, r17, 1
        custom 253, r9, r9, r10
        br draw_y
    draw_y_done:
    addi r16, r16, 1
    custom 253, r8, r8, r10
    br draw_x
    draw_x_done:
     

    ldw r4, 0(sp) 
    ldw r5, 4(sp) 
    ldw r6, 8(sp) 
    ldw r7, 12(sp) 
    ldw r8, 16(sp) 
    ldw r9, 20(sp) 
    ldw r10, 24(sp) 
    ldw r11, 28(sp) 
    ldw r12, 32(sp) 
    ldw r13, 36(sp) 
    ldw r14, 40(sp) 
    ldw r15, 44(sp) 
    ldw r16, 48(sp) 
    ldw r17, 52(sp) 
    ldw r18, 56(sp) 
    ldw r19, 60(sp) 
    ldw r20, 64(sp) 
    ldw r21, 68(sp) 
    ldw r22, 72(sp) 
    ldw r23, 76(sp) 
    ldw ra, 80(sp) 
  
    addi sp, sp, 88
 
    ret
