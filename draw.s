.equ VGA_ADDR, 0x08000000

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
    or r8, r8, r5
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
