.include "costants.asm"
.include "m_standard_syscalls.asm"
.include "m_support.asm"
.include "m_file.asm"

.data 
	separator: .asciiz "----------------------\n"
	char: .byte 1
	.align 2

.text
	.globl writeToFile

# In realta' bastava un metodo unico invece di due separati per la stampa su schermo e la scrittura su file,
# creando una specie di toString(), ma ho preferito non utilizzare spazio in memoria

writeToFile:
# Funzione che scrive su file un sudoku. 
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: nome del file
	
	.eqv FILENAME $a1
	.eqv ARRAY $s0 
	.eqv COUNTER $s1
	.eqv FILE $s2 
	.eqv CELLS 81
	
	subu $sp, $sp, 16
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move ARRAY, $a0
	li COUNTER, 0
	
	open_file (FILENAME, FILE_WRITE_MODE)
	move FILE, $v0

	write_file_label (FILE, separator, 23)
	write_file (FILE, "|", 1)
	
	while:
		#beq COUNTER CELLS exit di fatto finisce printSeparator 
		
		# Stampa la prossima cella, seguita da uno spazio
		lw $a0 0(ARRAY)
		add $a0, $a0, 48
		sb $a0, char
		
		write_file_label (FILE, char, 1)
		write_file (FILE, " ", 1)
		
		add ARRAY ARRAY 4 # Punta alla prossima cella
		addi COUNTER COUNTER 1
		
		# ogni 3 numeri, mettere |. Ogni 9, andare a capo, e ogni 27 aggiungere una riga di trattini
		divisible_for (COUNTER, 3) # 0 se divisible, 1 altrimenti
		beqz $v0, bar
		
		j while
		
	bar:
		write_file (FILE, "|", 1)
		divisible_for (COUNTER, 9)
		beqz $v0 printNewLine
		j while
		
	printNewLine:
		write_file (FILE, "\n", 1)
		divisible_for (COUNTER, 27)
		beqz $v0, printSeparator
		write_file (FILE, "|", 1)
		j while
	
	printSeparator:
		write_file_label (FILE, separator, 23)
		beq COUNTER CELLS, exit # Altrimenti ne stampa una in piu'
		write_file (FILE, "|", 1)
		j while
	
	exit:
		close_file (FILE)
		lw $ra, ($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		addu $sp, $sp, 16
		jr $ra
