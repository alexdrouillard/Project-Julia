.data
.align 2
   character_buffer1:  .space 32 
   character_buffer2:  .space 32 
   nice_message: .asciz "Enter seed (in form of a + ib):"
.equ JTAG_ADDR, 0xff201000
.text
.global poll_dat_jtag
poll_dat_jtag:
    addi sp, sp, -4
    stw ra, 0(sp)
    call print_nice_message
    movia r4, JTAG_ADDR
    movia r6, character_buffer1
    # start polling this until we get enter
    poll_loop:
        ldwio r5, 0(r4)
        srli r7, r5, 15
        andi r7, r7, 0x1
        beq r7, r0, poll_loop
        # we got valid DATA
        # put it in our array!
        andi r5, r5, 0x00FF

        write_dat_jtag:
        stwio r5, 0(r4) 
        # if this character is enter, we're DONEZO
        movui r7, 0x0A
        beq r5, r7, donezo
        # if this character is space, switch to the next buffer
        movui r7, 0x20
        bne r7, r5, read_some_real_stuff
        movia r6, character_buffer2
        movui r8, 0x2B
        stwio r8, 0(r4)
        movui r8, 0x20
        stwio r8, 0(r4)
        movui r8, 0x69
        stwio r8, 0(r4) 

        br poll_loop
        # if this character is neither, add to buffer and increment
        read_some_real_stuff:
        stb r5, 0(r6)
        addi r6, r6, 1
        br poll_loop

    donezo:
        movia r2, character_buffer1
        movia r3, character_buffer2
        ldw ra, 0(sp)
        addi sp, sp, 4
        ret

 
.global print_nice_message
print_nice_message: 
    movia r4, JTAG_ADDR
    movia r5, nice_message
    super_looper:
    ldbu r6, 0(r5)
    beq r6, r0, done_nice_message
    stwio r6, 0(r4)
    addi r5, r5, 1
    br super_looper

    done_nice_message:
    movui r6, 0x0A
    stwio r6, 0(r4)
    ret    



    
