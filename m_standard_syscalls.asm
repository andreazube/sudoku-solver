.eqv SYS_PRINT_INT 1
.eqv SYS_PRINT_FLOAT 2
.eqv SYS_PRINT_DOUBLE 3
.eqv SYS_PRINT_STRING 4
.eqv SYS_READ_INT 5
.eqv SYS_READ_FLOAT 6
.eqv SYS_READ_DOUBLE 7
.eqv SYS_READ_STRING 8
.eqv SYS_ALLOCATE_HEAP 9
.eqv SYS_EXIT 10

#######################################################################################################################
.macro print_int_reg (%reg)
	li $v0 SYS_PRINT_INT
	move $a0 %reg
	syscall
.end_macro
#######################################################################################################################
.macro print_int (%num)
	li $v0 SYS_PRINT_INT
	li $a0 %num
	syscall
.end_macro
#######################################################################################################################
.macro print_float_reg (%reg)
	li $v0 SYS_PRINT_FLOAT
	move $f12 %reg
	syscall
.end_macro
#######################################################################################################################
.macro print_string_reg (%reg)
	li $v0 SYS_PRINT_STRING
	move $a0 %reg
	syscall
.end_macro
#######################################################################################################################
.macro print_string (%str)
	.data
	stringa: .asciiz %str
	.text
	li $v0 SYS_PRINT_STRING
	la $a0 stringa
	syscall
.end_macro
#######################################################################################################################
.macro print_string_label (%label)
	li $v0 SYS_PRINT_STRING
	la $a0 %label
	syscall
.end_macro
#######################################################################################################################
.macro read_int
	li $v0 SYS_READ_INT
	syscall
.end_macro
#######################################################################################################################
.macro read_float
	li $v0 SYS_READ_FLOAT
	syscall
.end_macro
#######################################################################################################################
.macro read_double
	li $v0 SYS_READ_DOUBLE
	syscall
.end_macro
#######################################################################################################################
.macro read_string (%buffer, %buffer_length)
# @arg buffer             : Indirizzo del buffer dove memorizzare l'input letto
# @arg buffer_length: Immediato che indica la dimensione del buffer (in byte)

	la   $a0, %buffer   
	li   $a1, %buffer_length    
	li $v0 SYS_READ_STRING
	syscall
.end_macro
#######################################################################################################################
.macro allocate_heap (%size)
	li $v0 SYS_ALLOCATE_HEAP
	li $a0 %size
	syscall
.end_macro
#######################################################################################################################
.macro sys_exit
	li $v0 SYS_EXIT
	syscall
.end_macro
#######################################################################################################################
