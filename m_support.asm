#######################################################################################################################
.macro divisible_for (%dividendo, %divisore)
# @arg dividendo : Registro contenente il dividendo
# @arg divisore  : Immediato contenente il divisore
# @Return $v0    : 0 Se dividendo e' divisibile per divisore, 1 altrimenti

	move $a0, %dividendo
	li $a1, %divisore
	jal divisibleFor
.end_macro
#######################################################################################################################
.macro strip_string (%stringa, %default)
# @arg stringa : Label contenente l'indirizzo della stringa da controllare
# @arg default  : Stringa da usare come default in caso quella di input sia vuota

	.data
		default: .asciiz %default
	.text
	
	la $a0, %stringa
	la $a1, default
	jal stripString
.end_macro