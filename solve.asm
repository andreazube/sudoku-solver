.include "costants.asm"
.include "m_sudoku.asm"

.text
	.globl solve

solve:
# Funzione ricorsiva che trova la soluzione a un sudoku. Implementazione dell'algoritmo di backtracking
# https://en.wikipedia.org/wiki/Backtracking 
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella iniziale
# @Arg $a2: Ascissa della cella iniziale
# @Return $v0: 1 se il sudoku e' stato risolto, 0 se non e' risolvibile
	
	.eqv ARRAY $s0
	.eqv X $s1
	.eqv Y $s2
	.eqv CURRENTVALUE $s3 
	.eqv NEXT_X $s4 
	.eqv NEXT_Y $s5
	
	subu $sp, $sp, 28
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
	move ARRAY, $a0
	move X, $a2
	move Y, $a1
	
	# Per prima cosa, leggiamo il valore nella cella in input. Se diverso da 0, verifichiamo che sia un valore valido,
	# quindi passiamo al prossimo (o terminiamo la funzione se siamo all'ultima cella).
	# Se invece il valore e' proprio 0 (cella vuota), proviamo tutte le possibili combinazioni. Se nessuna funziona,
	# pulisce la cella e restituisce 0 (percorso non valido)
	
	read_cell (ARRAY, Y, X)
	beqz $v0, notYetDefined
	
alreadyDefined:
	is_valid_cell (ARRAY, Y, X)
	beqz $v0, exit # Non risolvibile, $v0 contiene gia' 0 (false)
	beq X, 8, lastX
	j increment
	
	lastX:
		beq Y, 8, solved # Siamo all'ultima cella, e tutti i valori sono validi
	
	increment:
		add NEXT_X, X, 1
		beq NEXT_X, 9, newRow
		j tryNext
		
	newRow:
		li NEXT_X, 0
		add NEXT_Y, Y, 1
			
	tryNext:
		solve (ARRAY, NEXT_Y, NEXT_X)
		beqz $v0, exit
		j solved

### Proviamo tutte le possibili combinazioni. Se una funziona, si prova quella dopo. Se nessuna funziona, si reimposta 
#       a 0 la cella attuale, e si restituisce 0 (questo percorso non funziona)

notYetDefined:
	li CURRENTVALUE, 0
	while:
		addi CURRENTVALUE, CURRENTVALUE, 1
		beq CURRENTVALUE, 10, endwhile
    
		write_cell (ARRAY, Y, X, CURRENTVALUE)
		is_valid_cell (ARRAY, Y, X)
		beqz $v0, while # Il valore che stiamo provando non va bene, via al prossimo (incremento messo dentro al ciclo)
		beq X, 8, lastX2
		j increment2
	
	lastX2:
		beq Y, 8, solved # Siamo all'ultima cella, e tutti i valori sono validi
	
	increment2:
		add NEXT_X, X, 1
		beq NEXT_X, 9, newRow2
		j tryNext2
		
	newRow2:
		li NEXT_X, 0
		add NEXT_Y, Y, 1
		
	tryNext2:
		solve (ARRAY, NEXT_Y, NEXT_X)
		beqz $v0, while # Proviamo il prossimo valore, questo NON VUOL DIRE CHE NON E' RISOLVIBILE
		j solved
		
endwhile: # Percorso non risolvibile
	write_cell (ARRAY, Y, X, $zero)
	li $v0, FALSE
	j exit

solved:
	li $v0, TRUE
	
exit:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addu $sp, $sp, 28
				
	jr $ra

	
