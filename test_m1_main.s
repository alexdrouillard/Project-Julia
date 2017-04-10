.equ sp_init, 0x017FFF80

.global main
main:

    movia sp, sp_init
looper:
    movia r4, 80
    movia r5, 60

    call draw_set

    br looper
