.include "costants.asm"
.include "m_standard_syscalls.asm"

.text 
	.globl createSudoku

createSudoku:
# Funzione che alloca memoria per una griglia sudoku. Tutto il progetto è stato impostato sull'avere funzioni generiche
# al posto di usare una variabile globale (l'array), in modo da rendere piu semplice future estensioni.
#
# @Return $v0: Indirizzo dell'array

	allocate_heap (MATRIX_DIMENSION)
	jr $ra
