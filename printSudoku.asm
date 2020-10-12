.include "costants.asm"
.include "m_standard_syscalls.asm"
.include "m_support.asm"

.data 
	separator: .asciiz "----------------------\n"

.text
	.globl printSudoku

printSudoku:
# Funzione che stampa una griglia sudoku (matrice 9x9), stampando 9 numeri per riga
#
# @Arg $a0: Indirizzo dell'array

	.eqv ARRAY $s0 
	.eqv COUNTER $s1 
	.eqv CELLS 81
	
	subu $sp, $sp, 12
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	move ARRAY, $a0
	li COUNTER, 0

	print_string_label (separator)
	print_string ("|")
	
	while:
		#beq COUNTER CELLS exit di fatto finisce printSeparator 
		
		# Stampa la prossima cella, seguita da uno spazio
		lw $a0 0(ARRAY)
		beqz $a0, empty
		print_int_reg ($a0)
		print_string (" ")
		j continue
	empty:
		print_string (". ")
	continue:
		
		add ARRAY ARRAY 4 # Punta alla prossima cella
		addi COUNTER COUNTER 1
		
		# ogni 3 numeri, mettere |. Ogni 9, andare a capo, e ogni 27 aggiungere una riga di trattini
		divisible_for (COUNTER, 3) # 0 se divisible, 1 altrimenti
		beqz $v0, bar
		
		j while
		
	bar:
		print_string ("|")
		divisible_for (COUNTER, 9)
		beqz $v0 printNewLine
		j while
		
	printNewLine:
		print_string ("\n")
		divisible_for (COUNTER, 27)
		beqz $v0, printSeparator
		print_string ("|")
		j while
	
	printSeparator:
		print_string_label (separator)
		beq COUNTER CELLS, exit # Altrimenti ne stampa una in piu'
		print_string ("|")
		j while
	
	exit:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		addu $sp, $sp, 12	
		jr $ra
