.include "costants.asm"
.include "m_sudoku.asm"

.text
	.globl isValidBox

isValidBox:
# Funzione che, data una cella in input, stabilice se questa ha un conflitto nella sua sezione 3x3
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: 1 se non ci sono collisioni, 0 altrimenti
	
	.eqv ARRAY $s0
	.eqv ORIGINAL_X $s1
	.eqv ORIGINAL_Y $s2
	.eqv ORIGINAL_VALUE $s3
	.eqv CURRENT_X $s4
	.eqv CURRENT_Y $s5
	.eqv FINAL_X $s6
	.eqv FINAL_Y $s7
	
	subu $sp, $sp, 36
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	
	move ARRAY, $a0
	move ORIGINAL_X, $a2
	move ORIGINAL_Y, $a1
	read_cell (ARRAY, ORIGINAL_Y, ORIGINAL_X)
	move ORIGINAL_VALUE, $v0
	
	# Calcola la x iniziale, ovvero la prima del quadrato
	# Guardando la griglia, ci si accorge che e' semplicemente il (quoziente di (x / 3)) * 3, ignorando il resto
	# (assumendo che la cella in alto a sinistra sia (0,0)) 
	#
	# Per esempio, se x = 1 allora x_iniziale = 0 (cioe' (1 // 3) * 3)
	# se x = 5, allora x_iniziale = 3 (cioe' (5 // 3) * 3)
	
	div CURRENT_X, ORIGINAL_X, 3
	mul CURRENT_X, CURRENT_X, 3
	
	# Calcola la y iniziale, stessa logica usata per la x
	div CURRENT_Y, ORIGINAL_Y, 3
	mul CURRENT_Y, CURRENT_Y, 3
	
	# Deve scorrere una griglia 3x3
	add FINAL_X, CURRENT_X, 3
	add FINAL_Y, CURRENT_Y, 3
	
while:
	beq CURRENT_Y, FINAL_Y, boxOk
	
col:
	beq CURRENT_X, ORIGINAL_X, sameX # Salta la cella originale

colNoSkip:
	read_cell (ARRAY, CURRENT_Y, CURRENT_X)
	beq ORIGINAL_VALUE, $v0, collision
	
increment:
	# Si poteva invertire l'ordine e risparmiare qualche istruzione impostando final_x = x + 2 invece che x + 3,
	# ma ritengo sia piu' leggibile cosi'
	add CURRENT_X, CURRENT_X, 1 
	beq CURRENT_X, FINAL_X, newRow
	j col

newRow:
	subi CURRENT_X, CURRENT_X, 3
	addi CURRENT_Y, CURRENT_Y, 1
	j while
	
sameX:
	beq CURRENT_Y, ORIGINAL_Y, increment
	j colNoSkip
	
boxOk:
	li $v0, TRUE
	j exit

collision:
	li $v0, FALSE
	j exit

exit:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	addu $sp, $sp, 36
	jr $ra
	
