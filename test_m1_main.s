.equ sp_init, 0x017FFFF80
.equ VGA_ADDR, 0x08000000
.text
.global main
main:
    movia sp, sp_init
    
    movia r4, 0
    movia r5, 0
    movia r6, 0
    call draw_set
    
    movia r4, 0
    movia r5, 0
    movia r6, 0

    call draw_box
    call load_box

looper:
    br looper
