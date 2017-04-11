.equ sp_init, 0x017FFF80

.global main
main:

    movia sp, sp_init


looper:
    movia r4, 80
    movia r5, 60
    movia r6, 1 
    call draw_set

    movia r4, 0
    movia r5, 0
#    call draw_box    


br looper
