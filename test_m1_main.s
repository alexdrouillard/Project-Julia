.data
.align 2
box_x: .word 80
box_y: .word 60
left_box: .store 118
right_box: .store 118
top_box: .store 160
bot_box: .store 160

.equ sp_init, 0x017FFF80
.equ left, 0x40000000 #-2.0
.equ right, 0xC0000000 #2.0
.equ top, 0x3f800000 #1.0 GPA sad bois
.equ bot, 0xbf800000 #-1.0 
.equ width, 0x43A00000 #320.0 in hex
.equ height, 0x43700000 #240.0 in hex

.global main
main:

    movia sp, sp_init


    call draw_set

looper:
	br looper

