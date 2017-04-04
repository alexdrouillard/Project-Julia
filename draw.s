.equ VGA_ADDR, 0x08000000
.equ X_COORD_MAX, 320
.equ Y_COORD_MAX, 240


.equ left, 0x40000000 #-2.0
.equ right, 0xC0000000 #2.0
.equ top, 0x3f800000 #1.0 GPA sad bois
.equ bot, 0xbf800000 #-1.0 
.equ width, 0x43A00000 #320.0 in hex
.equ height, 0x43700000 #240.0 in hex

.global draw_pixel
# r4 = x
# r5 = y
# r6 = color
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
    addi sp, sp, -84
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
    calculate_x_constant:
        movia r16, left
        movia r17, right

        mov r5, r16
        mov r4, r17

        call float_subtract

        mov r4, r2
        movia r5, width

        call float_divide

        mov r20, r2 # r20 holds (right - left)/width

    calculate_y_constant:
        movia r16, top
        movia r17, bot

        mov r5, r16
        mov r4, r17

        call float_subtract

        mov r4, r2
        movia r5, height

        call float_divide

        mov r21, r2 # r21 holds (bot - top)/height

    mov r16, r0 #screen_x
    mov r17, r0 #screen_y

    movia r18, X_COORD_MAX
    movia r19, Y_COORD_MAX

    draw_x:
    beq r16, r18, draw_x_done
    mov r17, r0
        draw_y:
        beq r17, r19, draw_y_done
        
        # xconstant = r20
        # yconstant = r21
        # x = r16
        # y = r17 

        # convert int x into float
        mov r4, r16
        call int_to_float
        mov r22, r2

        # do x * xconstant
        mov r4, r22
        mov r5, r20
        call float_multiply
        mov r22, r2

        # convert int y into float
        mov r4, r17
        call int_to_float
        mov r23, r2

        # do y * yconstant
        mov r4, r23
        mov r5, r21
        call float_multiply
        mov r23, r2

        # do left + x*xconstant
        movia r4, left
        mov r5, r22
        call float_add
        mov r22, r2

        # do top + y*yconstant
        movia r4, top
        mov r5, r23
        call float_add
        mov r23, r2

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
        br draw_y
    draw_y_done:
    addi r16, r16, 1
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
  
    addi sp, sp, 84
 
    ret
