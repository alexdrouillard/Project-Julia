.equ sp_init, 0x017FFFF80


.global main
main:
    movia sp, sp_init
    loop:    
        call read_valid

    br loop   




movi r4, 0
movi r5, 0

movia sp, sp_init

call iterate
mov r4, r2
mov r5, r3
call print_complex

call iterate
mov r4, r2
mov r5, r3
call print_complex
