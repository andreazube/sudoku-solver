.include "costants.asm"
.include "m_sudoku.asm"

.text
	.globl isValidCol

isValidCol:
# Funzione che, data una cella in input, stabilice se questa ha un conflitto con un'altra cella nella sua colonna 
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: 1 se non ci sono collisioni, 0 altrimenti
	
	.eqv ARRAY $s0
	.eqv X $s1
	.eqv ORIGINAL_Y $s2
	.eqv ORIGINAL_VALUE $s3
	.eqv FINAL_Y 9
	.eqv CURRENT_Y $s4
	
	subu $sp, $sp, 24
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	
	move ARRAY, $a0
	move X, $a2
	move ORIGINAL_Y, $a1
	read_cell (ARRAY, ORIGINAL_Y, X)
	move ORIGINAL_VALUE $v0
	li CURRENT_Y, 0

while:
	beq CURRENT_Y, FINAL_Y, colOk
	beq CURRENT_Y, ORIGINAL_Y, increment # Salta se stessa
	read_cell (ARRAY, CURRENT_Y, X)
	beq ORIGINAL_VALUE, $v0, collision

	increment:
	add CURRENT_Y, CURRENT_Y, 1
	j while
	
colOk:
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
	addu $sp, $sp, 24
	jr $ra
	
