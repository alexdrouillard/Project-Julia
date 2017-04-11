.equ sp_init, 0x017FFF80
.text
.global main
main:

    movia sp, sp_init
    

    
init:
    movia r4, 0
    movia r5, 0
    movia r6, 1
    call draw_set
    call save_box
    call draw_box

    movia r4, 0
    movia r5, 0
    movia r6, 0

looper:
    call read_valid
    # store old values
    addi sp, sp, -16
    stw r4, 0(sp)
    stw r5, 4(sp) 
    #call load_box 
    # here r2 will contain information about keypresses
    movia r8, 0x72
    beq r2, r8, move_down
    br next_case_1
    
    move_down:
    addi r5, r5, 1
    br done_case

    next_case_1:
    movia r8, 0x75
    beq r2, r8, move_up
    br next_case_2
    move_up:
    addi r5, r5, -1
    br done_case

    
    next_case_2:
    movia r8, 0x6B
    beq r2, r8, move_left
    br next_case_3
    move_left:
    addi r4, r4, -1
    br done_case


    next_case_3:
    movia r8, 0x74
    beq r2, r8, move_right
    br next_case_4
    move_right:
    addi r4, r4, 1
    br done_case


    next_case_4:
    movia r8, 0x79
    beq r2, r8, zoomer
    br next_case_5
    zoomer:
    movui r6, 1
    br redraw_set


    next_case_5:
    movia r8, 0x7B
    beq r2, r8, zoom_outer
    br next_case_6
    zoom_outer:
    movui r6, 2
    br redraw_set

    next_case_6:

done_case:
    stw r4, 8(sp)
    stw r5, 12(sp)
    ldw r4, 0(sp)
    ldw r5, 4(sp) 
    call load_box
    ldw r4, 8(sp)
    ldw r5, 12(sp)
    addi sp, sp, 16
    call save_box 
    call draw_box
br looper

redraw_set:
    call draw_set
    call save_box 
    br looper

