.data
.align 2
box_x: .word 80
box_y: .word 60
left_box: .store 118
right_box: .store 118
top_box: .store 160
bot_box: .store 160

.equ sp_init, 0x017FFF80

.global main
main:

    movia sp, sp_init
looper:
    movia r4, 80
    movia r5, 60

    call draw_set
br looper
