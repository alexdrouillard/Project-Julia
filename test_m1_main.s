.equ sp_init, 0x017FFF80

.global main
main:

    movia sp, sp_init



    movia r4, 80
    movia r5, 60
    movia r6, 2
    call draw_set
    movia r4, 50
    movia r5, 50
    call draw_box

looper:

br looper

