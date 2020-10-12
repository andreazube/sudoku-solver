.include "m_sudoku.asm"

.text
	.globl writeCell

writeCell:
# Funzione che inserisce un numero all'interno della griglia sudoku
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Arg $a3: Valore da inserire
	
	.eqv ARRAY $a0
	.eqv Y $a1
	.eqv X $a2
	.eqv VALUE $s0
	
	subu $sp, $sp, 8
	sw $ra, ($sp)
	sw $s0, 4($sp)
	
	move VALUE, $a3
	
	get_cell_address (ARRAY, Y, X)
	sw VALUE, ($v0)
	
	lw $ra, ($sp)
	lw $s0, 4($sp)
	addu $sp, $sp, 8
	jr $ra
	
