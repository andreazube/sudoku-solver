.text
    .globl divisibleFor

divisibleFor:
# Funzione che stabilisce se un numero in input e' divisibile per un altro (resto della divisione 0)
#
# @Arg $a0 : Dividendo
# @Arg $a1: Divisore
# @Return: 0 se il il dividendo e' divisibile per il divisore, 1 altrimenti

	div $a0, $a1
	mfhi $v0
	beqz $v0, exit
	li $v0, 1

exit:
	jr $ra
 
