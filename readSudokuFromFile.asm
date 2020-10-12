.include "m_sudoku.asm"
.include "m_file.asm"

.text
    .globl readSudokuFromFile

readSudokuFromFile:
# Funzione che legge un file di testo contenente un sudoku, e ne carica il contenuto in memoria.
# Il file deve contenere esattamente 81 cifre, che possono essere separate da caratteri qualsiasi
# (in particolare whitespace)
#
# @Arg $a0 : Indirizzo contenente il nome del file da leggere
# @Return $v0 : Indirizzo dell'array contenente il sudoku letto
# @Return $v1 : flag di uscita, 0 se tutto e' andato a buon fine e -1 altrimenti

	.eqv SUDOKUADDRESS $s0
	.eqv FILE $s1
	.eqv FILENAME $a0
	.eqv EXIT_CODE_ERROR -1
	.eqv EXIT_CODE_OK 0
	
	subu $sp, $sp, 12
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	open_file (FILENAME, FILE_READ_MODE)
	move FILE, $v0 
	blt FILE, 0, file_error # open_file restituisce un intero negativo in caso di errori
	
	jal createSudoku
	move SUDOKUADDRESS, $v0 
	
	populate_sudoku (FILE, SUDOKUADDRESS)
	beq $v0, -1, file_error # populate_sudoku restituisce -1 in caso di errori
	
	li $v1, EXIT_CODE_OK
	
exit:
	close_file (FILE)
	move $v0 SUDOKUADDRESS
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addu $sp, $sp, 12	
	jr $ra
	
file_error:
	li $v1, EXIT_CODE_ERROR
	j exit
