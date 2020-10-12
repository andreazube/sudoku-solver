#######################################################################################################################
########################################### MACRO PUBBLICHE (alto livello) ############################################
#######################################################################################################################

#######################################################################################################################
.macro write_cell (%array, %y, %x, %val)
# @arg array : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y    : Registro contentente il valore dell'ordinata 
# @arg %x    : Registro contenente il valore dell'ascissa
# @arg %val  : Registro contenente il valore da scrivere nella cella

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	move $a3, %val
	jal writeCell
.end_macro
#######################################################################################################################
.macro read_cell (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : Valore contenuto nella cella 

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal readCell
.end_macro
#######################################################################################################################
.macro print_sudoku (%array)
# @arg array : Registro contenente l'indirizzo della prima cella (array[0][0]) dell'array da stampare

	move $a0, %array
	jal printSudoku
.end_macro
#######################################################################################################################
.macro read_sudoku_from_file (%filename)
# @arg filename : Indirizzo della stringa nomeFile   
# @Return $v0   : Indirizzo dell'array contenente il sudoku letto
# @Return $v1   
# 	 0 	se la procedura e' andata a buon fine
#	-1 	se ci sono stati problemi

	la  $a0, %filename
	jal readSudokuFromFile
.end_macro
#######################################################################################################################
.macro solve (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : 1 se non ci sono collisioni, 0 altrimenti

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal solve
.end_macro
#######################################################################################################################


#######################################################################################################################
########################################### MACRO PRIVATE (supporto) ##################################################
#######################################################################################################################

#######################################################################################################################
.macro is_valid_cell (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : 1 se non ci sono collisioni, 0 altrimenti

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal isValidCell
.end_macro
#######################################################################################################################
.macro is_valid_row (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : 1 se non ci sono collisioni, 0 altrimenti

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal isValidRow
.end_macro
#######################################################################################################################
.macro is_valid_col (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : 1 se non ci sono collisioni, 0 altrimenti

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal isValidCol
.end_macro
#######################################################################################################################
.macro is_valid_box (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro contentente il valore dell'ordinata 
# @arg %x     : Registro contenente il valore dell'ascissa
# @return $v0 : 1 se non ci sono collisioni, 0 altrimenti

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal isValidBox
.end_macro
#######################################################################################################################
.macro populate_sudoku (%file, %sudoku)
# @arg file   : Registro contenente il file address del file che stiamo leggendo	      
# @arg sudoku : Registro contenente l'indirizzo della prima cella dell'array da riempire 
# @Return $v0 :
# 	 0 	se la procedura e' andata a buon fine
#	-1 	se ci sono stati problemi (tipicamente raggiunto EOF prima di riempire la matrice) 

	move $a0, %file
	move $a1, %sudoku
	jal populateSudoku
.end_macro
#######################################################################################################################
.macro get_cell_address (%array, %y, %x)
# @arg array  : Registro contenente l'indirizzo dell'array in cui scrivere 
# @arg %y     : Registro  contentente il valore dell'ordinata 
# @arg %x     : Registro  contenente il valore dell'ascissa
# @return $v0 : Indirizzo della cella corrispondente

	move $a0 ,%array
	move $a1, %y
	move $a2, %x
	jal getCellAddress
.end_macro
