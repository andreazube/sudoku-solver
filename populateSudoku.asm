.include "m_file.asm"
.include "costants.asm"

.text
	.globl populateSudoku

populateSudoku:
# Funzione che prende in input un file descriptor, e l'indirizzo di un array (la griglia sudoku)
# Riempie l'array con le cifre presenti nel file in input. Nello specfico, continua a riempire fino a quando
# trova 81 cifre (cifre, non caratteri) oppure raggiunge EOF
#
# @Args $a0: file descriptor
# @Args $a1: indirizzo dell'array
# @Return $v0:
# 	 0 	se la procedura e' andata a buon fine
#	-1 	se ci sono stati problemi (tipicamente raggiunto EOF prima di riempire la matrice) 


	.eqv FILE $s0
	.eqv CURRENTCELL $s1
	.eqv LASTCELL $s2
	.eqv DIGIT $v0

	subu $sp, $sp, 16
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)

	move FILE, $a0
	move CURRENTCELL, $a1
	addi LASTCELL, CURRENTCELL, MATRIX_DIMENSION

while:
	next_digit (FILE)
	
	beq DIGIT, -1, exit 
	beq DIGIT, -2, while # Trovato carattere che non e' cifra
	
	# Trovata cifra, inserimento in array e incremento contatore
	sw DIGIT, (CURRENTCELL)
	addi CURRENTCELL, CURRENTCELL, 4
	beq CURRENTCELL, LASTCELL, endwhile
	j while
	
endwhile:
	li $v0, 0
	j exit
	
exit:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addu $sp, $sp, 16	
				
	jr $ra
