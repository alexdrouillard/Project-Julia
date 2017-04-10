.equ sp_init, 0x017FFF80

.global main
main:

    movia sp, sp_init
looper:
    movia r4, 50
    movia r5, 50

    call draw_set


    br looper
