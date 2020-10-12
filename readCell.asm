.include "m_sudoku.asm"
.include "m_standard_syscalls.asm"

.text
	.globl readCell

readCell:
# Funzione che legge il valore di una cella  all'interno della griglia sudoku
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: il valore nella cella (dovrebbe essere sempre un intero 0 <= k <= 9)

	.eqv ARRAY $a0
	.eqv Y $a1
	.eqv X $a2
	
	subu $sp, $sp, 4
	sw $ra, ($sp)
	
	get_cell_address (ARRAY, Y, X)
	lw $v0, ($v0)
	
	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
	
