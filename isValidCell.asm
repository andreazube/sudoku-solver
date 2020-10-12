.include "costants.asm"
.include "m_sudoku.asm"

.text
	.globl isValidCell

isValidCell:
# Funzione che, data una cella in input, stabilice se questa ha un conflitto con un'altra cella nella sua colonna,
# riga oppure sezione 3x3
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: 1 se non ci sono collisioni, 0 altrimenti

	.eqv ARRAY $s0
	.eqv X $s1
	.eqv Y $s2
	
	subu $sp, $sp, 16
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move ARRAY, $a0
	move X, $a2
	move Y, $a1
	
	is_valid_row (ARRAY, Y, X)
	beqz $v0, collision
	
	is_valid_col (ARRAY, Y, X)
    	beqz $v0, collision
	
	is_valid_box (ARRAY, Y, X)
	beqz $v0, collision # Se non salta a collision, $v0 e' gia' 1, inutile scrivere li $v0, TRUE
	
exit:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addu $sp, $sp, 16
	jr $ra
	
collision:
	li $v0, FALSE
	j exit
