.include "m_standard_syscalls.asm"

.text
	.globl stripString
	
stripString:
# Funzione che elimina il carattere \n posto in automatico da MARS alla fine da una stringa presa in input.
# Se la stringa e' vuota, la trasforma in un'altra scelta come secondo argomento.
#
# @Arg $a0 : Indirizzo della stringa
# @Arg $a1 : Stringa da inserire di default nel caso l'originale sia vuota

	.eqv STRING $a0
	.eqv DEFAULT $a1
	.eqv CHAR $t0
	.eqv ORIGINALSTRING $t1
	.eqv NULL 0 # ASCII per il carattere di terminazione
	.eqv NL 10 # ASCII per \n
	
	move ORIGINALSTRING, STRING
	
while: # Continua a scorrere fino a quando non trova il carattere di terminazione (ASCII 0)

	lb CHAR, (STRING) 
	beqz CHAR, remove_nl
	addi STRING, STRING, 1 # Next character
	j while

remove_nl: # Se l'ultimo carattere prima di NULL e' \n, lo elimina sostituendolo con NULL

	lb CHAR, -1(STRING) 
	bne CHAR, NL, isEmpty
	li CHAR, NULL 
	sb CHAR, -1(STRING) 

isEmpty: # Guarda se il primo carattere e' NULL
	lb CHAR, (ORIGINALSTRING) # Load first byte of the string.
	beq CHAR, NULL, copy_default # Exit if first byte is NUL terminator

exit:
	jr $ra
	
copy_default: # Semplice copia byte a byte. Non viene effettuato nessun controllo sulla lunghezza delle due stringhe.
	while2:
		lb CHAR, (DEFAULT)
		sb CHAR, (ORIGINALSTRING) 
		beqz CHAR, exit
		addi ORIGINALSTRING, ORIGINALSTRING, 1 
		addi DEFAULT, DEFAULT, 1
		j while2