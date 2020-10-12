.include "m_file.asm"

.data
    char: .space 1

.text           
    .globl nextDigit

nextDigit:
# Funzione che prende in input un file descriptor, e legge il prossimo carattere
#
# @Arg $a0: file descriptor
# @Return $v0:
# 	{cifra} Se si tratta di una cifra 
# 	-1 	Se si tratta di EOF
# 	-2	Se si tratta di qualsiasi altra cosa

	.eqv FILE $a0
	.eqv CHAR $t0
	.eqv ASCII_0 48 # Codice ASCII di '0'
	.eqv ASCII_9 57 # Codice ASCII di '9'
	.eqv EXIT_CODE_EOF -1
	.eqv EXIT_CODE_ERROR -2

	read_file ($a0, char, 1) # Legge esattamente un byte dal file
	beqz $v0, EOF # read_file restituisce 0 se EOF
	blt $v0, 0, error # read_file restituisce un  numero negativo in caso di errore
	lb CHAR, char 
	blt CHAR, ASCII_0, error  # Controlla se non e' una cifra (ASCII < '0')
	bgt CHAR, ASCII_9, error  
	addi $v0, CHAR, -ASCII_0  #Converte il valore ASCII in decimale
	jr $ra
	
EOF:
	li $v0, EXIT_CODE_EOF
	jr $ra	
error:
	li $v0, EXIT_CODE_ERROR
	jr $ra
