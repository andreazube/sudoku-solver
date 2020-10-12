.text
	.globl getCellAddress

getCellAddress:
# Funzione che, date in input le coordinate di una cella, calcola la posizione della cella all'interno dell'array
# Per trasformare il vettore in array, usa la formula "indice = y * (num_col) + x"
#
# @Arg $a0: Indirizzo dell'array
# @Arg $a1: Ordinata della cella
# @Arg $a2: Ascissa della cella
# @Return $v0: l'indirizzo della cella
	
	mul $a1, $a1, 9   #   y = y * 9
	add $a1, $a1, $a2 # $a1 = y * 9 + x
	mul $a1, $a1, 4   # Conversione indice ==> parole
	add $v0, $a0, $a1
	
	jr $ra
	
