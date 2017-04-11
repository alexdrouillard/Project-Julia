.equ two_in_float, 0x40000000
.text
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
    custom 252, r7, r5, r6 # do (b*c)
    
    # addition
    custom 253, r3, r3, r7 # do (a*d + b*c)
    ret

.global complex_magnitude
complex_magnitude:
    custom 252, r2, r4, r4 # (a*a)
    custom 252, r3, r5, r5 # (b*b)
    custom 253, r2, r2, r3 # (a*a + b*b)
    ret 

.global complex_square
complex_square:
    custom 252, r2, r4, r4          #(a^2 - b^2) + 2abi
    custom 252, r3, r5, r5
    custom 254, r2, r2, r3
    custom 252, r3, r4, r5
    movia r6, two_in_float 
    custom 252, r3, r3, r6
    ret
