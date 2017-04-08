.global complex_add
complex_add:
    # addition
    custom 253, r2, r4, r6 
    custom 253, r3, r5, r7   
    ret

.global complex_subtract
complex_subtract:
    # subtraction
    custom 254, r2, r4, r6
    custom 254, r3, r5, r7  
    ret

.global complex_multiply
complex_multiply:
    # multiplication
    custom 252, r2, r4, r6 # do (a*c)	
    custom 252, r3, r5, r7 # do (b*d)
    # subtraction
    custom 254, r2, r2, r3 # do (a*c - b*d)
    
    # multiplication
    custom 252, r3, r4, r7 # do (a*d)
    addi sp, sp, -4
    stw r2, 0(sp)
    custom 252, r2, r5, r6 # do (b*c)
    
    # addition
    custom 253, r3, r3, r2 # do (a*d + b*c)
    ldw r2, 0(sp)
    addi sp, sp, 4
    ret

.global complex_magnitude
complex_magnitude:
    custom 252, r2, r4, r4 # (a*a)
    custom 252, r3, r5, r5 # (b*b)
    custom 253, r2, r2, r3 # (a*a + b*b)
    ret 
