.equ VGA_ADDR, 0x08000000
.equ X_COORD_MAX, 320
.equ Y_COORD_MAX, 240
.global draw_pixel
# r4 = x
# r5 = y
# r6 = color
draw_pixel: 
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

    # need to call calculate for every pixel on the screen,
    # then we need to convert the color from hsv to rgb, then draw it on the screen
    mov r8, r0 #draw at x
    mov r9, r0 #draw at y

    srli r10, r8, 1 #divide r8 by 2
    muli r10, -1

    srli r11, r9, 1 #indicies into julia set
    muli r11, -1    
 
    movia r12, X_COORD_MAX #i
    movia r13, Y_COORD_MAX #j
    srli r12, 1
    srli r13, 1
    # r12 is x for julia set
    # r13 is y for julia set

    calculate_X:
    beq r8, r12, done_X
    mov r9, r0
        calculate_Y:
        beq r9, r13
        # for each indicies, add offset and call julia set
        # convert to floating point and call julia set
        addi sp, sp, -28
        stw r8, 0(sp)
        stw r9, 4(sp)
        stw r10, 8(sp)
        stw r11, 12(sp)
        stw r12, 16(sp)
        stw r13, 20(sp)
        
        mov r4, r10
        call int_to_float
        stw r2, 24(sp) 

        mov r4, r11
        call int_to_float
        
        mov r5, r2
        ldw r4, 24(sp)
        call calculate

        #here we have our number of iterations in r2 
        mov r4, r2
        call hsv_to_rgb

        mov r6, r2
        ldw r4, 0(sp)
        ldw r5, 4(sp)      
        call draw_pixel
        
        ldw r8, 0(sp)
        ldw r9, 4(sp)
        ldw r10, 8(sp) 
        ldw r11, 12(sp)
        ldw r12, 16(sp)
        ldw r13, 20(sp)
        addi sp, sp, 28

        #done this iteration, add to y
        addi r9, r9, 1
        addi r11, r11, 1 
        br calculate_Y 
    done_Y:
    br calculate_X         
    addi r8, r8, 1
    addi r10, r10, 1 
    done_X:

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
