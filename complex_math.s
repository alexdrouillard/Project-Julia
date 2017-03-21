.global complex_add
complex_add: 	
	addi 	sp, sp, -24				# (a + bi) + (c + di)
	stw		ra,	20(sp)				#  (r4 + r5i) + (r6 + r7i)
	stw		r7,	12(sp)				# d
	stw		r6,	8(sp)				# c
	stw		r5,	4(sp)				# b
	stw		r4,	0(sp)				# a

	mov 	r5, r6					# move c component into function input
	call 	float_add				#
									#
	stw		r2, 16(sp)				# store result

	ldw		r4, 4(sp)				# move b into 1st arg
	ldw		r5, 12(sp)				# move d into 2nd arg
	call 	float_add				#

	mov 	r3, r2					# move result into complex return
	ldw 	r2, 16(sp)				# ld result into real return

	ldw 	ra, 20(sp)				# sp stuff
	ldw		r7,	12(sp)				#
	ldw		r6,	8(sp)				#
	ldw		r5,	4(sp)				#
	ldw		r4,	0(sp)

	addi	sp, sp, 24				# increment sp

	ret

.global complex_subtract
complex_subtract: 	
	addi 	sp, sp, -24				# (a + bi) - (c + di)
	stw		ra,	20(sp)				# (r4 + r5i) - (r6 + r7i)
	stw		r7,	12(sp)				# d
	stw		r6,	8(sp)				# c
	stw		r5,	4(sp)				# b
	stw		r4,	0(sp)				# a

	mov 	r5, r6					# move c component into function input
	call 	float_subtract			#
									#
	stw		r2, 16(sp)				# store result

	ldw		r4, 4(sp)				# move b into 1st arg
	ldw		r5, 12(sp)				# move d into 2nd arg
	call 	float_subtract			#

	mov 	r3, r2					# move result into complex return
	ldw 	r2, 16(sp)				# ld result into real return

	ldw 	ra, 20(sp)				# sp stuff
	ldw		r7,	12(sp)				#
	ldw		r6,	8(sp)				#
	ldw		r5,	4(sp)				#
	ldw		r4,	0(sp)

	addi	sp, sp, 24				# increment sp

	ret

.global complex_multiplication
complex_multiplication:				
	addi 	sp, sp, -44				# (a + ib) * (c + id) = (ac - bd) + i(ad + bc)
	stw		ra,	20(sp)				# (r4 * r6 - r5 * r7) + (r4 * r7 + r5 * r6)
	stw		r7,	12(sp)				# d
	stw		r6,	8(sp)				# c
	stw		r5,	4(sp)				# b
	stw		r4,	0(sp)				# a

	mov 	r5, r6					# do a * c
	call 	float_multiply
	stw		r2,	24(sp)				# store a * c on 24(sp)

	ldw		r4,	4(sp)				# do b * d
	ldw 	r5, 12(sp)
	call 	float_multiply
	stw		r2, 28(sp)				# store b * d on 28(sp)

	ldw 	r4, 24(sp)				# do (a * c - b * d)
	ldw		r5, 28(sp)				
	call 	float_subtract
	stw 	r2,	32(sp)				# store (ac - bd) on 32(sp)

	ldw 	r4, 0(sp)				# do a * d
	ldw		r5, 12(sp)
	call	float_multiply			
	stw 	r2, 36(sp)				# store (ad) on 36(sp)

	ldw		r4, 4(sp)				# do b * c
	ldw		r5, 8(sp)
	call	float_multiply
	stw 	r2, 40(sp)				# store (bc) on 40(sp)

	ldw 	r4, 36(sp)				# do (ad + bc)
	ldw		r5, 40(sp)
	call	float_add
	mov 	r3, r2					# put imaginary component onto r3
	ldw		r2, 32(sp)				# put real component onto r2

	ldw 	ra, 20(sp)
	ldw 	r7, 12(sp)
	ldw 	r6, 8(sp)
	ldw 	r5, 4(sp)
	ldw 	r4, 0(sp)
	addi 	sp, sp, 44

	ret


.global complex_division
complex_division:
	addi 	sp, sp, -64				# (a + ib) / (c + id) = ((ac + bd) + i(bc - ad))/(c^2+d^2)
	stw		ra,	20(sp)				# (r4 * r6 + r5 * r7) + (r5 * r6 - r4 * r7)/(r)
	stw		r7,	12(sp)				# d
	stw		r6,	8(sp)				# c
	stw		r5,	4(sp)				# b
	stw		r4,	0(sp)				# a

	mov 	r5, r6					# do a * c
	call 	float_multiply
	stw		r2,	24(sp)				# store a * c on 24(sp)

	ldw		r4,	4(sp)				# do b * d
	ldw 	r5, 12(sp)
	call 	float_multiply
	stw		r2, 28(sp)				# store b * d on 28(sp)

	ldw		r4, 24(sp)				#do  (ac + bd)
	ldw		r5, 28(sp)
	call 	float_add
	stw		r2, 32(sp)				#store (ac + bd) on 32(sp)

	ldw		r4, 4(sp)				#do b * c
	ldw		r5, 8(sp)
	call 	float_multiply
	stw 	r2, 36(sp)				#store b * c on 36(sp)

	ldw		r4, 0(sp)				#do a * d
	ldw 	r5, 12(sp)
	call 	float_multiply
	stw		r2, 40(sp)				#store a * d on 40(sp)

	ldw 	r4, 36(sp)				#do (bc - ad)
	ldw		r5, 40(sp)
	call 	float_subtract
	stw		r2, 44(sp)				#store (bc - ad) on 44(sp)

	ldw		r4, 8(sp)				#do c^2
	mov 	r5, r4
	call 	float_multiply
	stw		r2, 48(sp)				#store c^2 on 48(sp)

	ldw		r4, 12(sp)				#do d^2
	mov 	r5, r4
	call 	float_multiply
	stw 	r2, 52(sp)				#store d^2 on 52(sp)

	ldw		r4, 48(sp)				#do c^2 + d^2
	ldw		r5, 52(sp)
	call 	float_add
	stw 	r2, 56(sp) 				#store denominator

	ldw		r4, 32(sp)				#do (ac + bd)/(c^2 + d^2)
	ldw		r5, 56(sp)
	call 	float_divide
	stw		r2, 60(sp)				#store real value

	ldw		r4, 44(sp)				#do (bc - ad)/(c^2 + d^2)
	ldw 	r5, 56(sp)			
	call 	float_divide			

	mov 	r3, r2					#put complex value on complex return 
	ldw 	r2, 60(sp)				#put real answer on real return 

	ldw 	ra, 20(sp)
	ldw 	r7, 12(sp)
	ldw 	r6, 8(sp)
	ldw 	r5, 4(sp)
	ldw 	r4, 0(sp)
	addi 	sp, sp, 64

	ret





