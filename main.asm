.include "m_sudoku.asm"
.include "m_standard_syscalls.asm"
.include "m_support.asm"

.data
	input : .byte 50
	output: .byte 50
	
.text
	.globl main
	
main: 
	.eqv SUDOKU $s0
	
	print_string ("Inserire il nome del file di input (default:\"sudoku.txt\"): ")
	read_string (input, 50)
	print_string ("\n")
	strip_string (input, "sudoku.txt")
	
	read_sudoku_from_file (input)
	move SUDOKU, $v0
	beq $v1, -1, file_error # read_sudoku_from_file restituisce -1 in caso di errori
	
	print_string ("### Griglia iniziale ###\n\n")
	print_sudoku (SUDOKU)
	
	solve (SUDOKU, $zero, $zero) # Risolvi a partire dalla prima cella (0, 0)
	beqz, $v0, impossible
	
	print_string ("\n### SOLUZIONE ###\n\n")
	print_sudoku (SUDOKU)
	
	print_string ("Inserire il nome del file di output (default:\"soluzione.txt\"): ")
	read_string (output, 50)
	print_string ("\n")
	strip_string (output, "soluzione.txt")
	
	move $a0, SUDOKU
	la $a1, output
	jal writeToFile

exit:
	sys_exit
	
file_error:
	print_string ("##### Errore nella lettura del file. #####\n")
	j exit

impossible:
	print_string ("##### Il sudoku non e' risolvibile #####\n")
	j exit
