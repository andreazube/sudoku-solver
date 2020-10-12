.include "costants.asm"
.include "m_sudoku.asm"

.text
	.globl isValidRow

isValidRow:
# Funzione che, data una cella in input, stabilice se questa ha un conflitto con un'altra cella nella sua riga 
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: 1 se non ci sono collisioni, 0 altrimenti
	
	.eqv ARRAY $s0
	.eqv ORIGINAL_X $s1
	.eqv Y $s2
	.eqv ORIGINAL_VALUE $s3
	.eqv FINAL_X 9
	.eqv CURRENT_X $s4
	
	subu $sp, $sp, 24
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	
	move ARRAY, $a0
	move ORIGINAL_X, $a2
	move Y, $a1
	read_cell (ARRAY, Y, ORIGINAL_X)
	move ORIGINAL_VALUE $v0
	li CURRENT_X, 0
	
while:
	beq CURRENT_X, FINAL_X, rowOk
	beq CURRENT_X, ORIGINAL_X, increment # Salta se stessa
	read_cell (ARRAY, Y, CURRENT_X)
	beq ORIGINAL_VALUE, $v0, collision

	increment:
	add CURRENT_X, CURRENT_X, 1
	j while
	
rowOk:
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
	
