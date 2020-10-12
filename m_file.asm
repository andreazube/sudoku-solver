.eqv SYS_OPEN_FILE 13
.eqv SYS_READ_FILE 14
.eqv SYS_WRITE_FILE 15
.eqv SYS_CLOSE_FILE 16

.eqv FILE_READ_MODE 0
.eqv FILE_WRITE_MODE 1
.eqv FILE_APPEND_MODE 9

#######################################################################################################################
.macro open_file (%filename, %mode)
# Macro per aprire un file in lettura/scrittura/append
#
# @arg filename: Registro contenente Indirizzo della stringa contenente il nome del file
# @arg mode: 	 Immediato che indica in quale modalita' aprire il file.
#	     	    			Dovrebbe essere 0, 1 oppure 9, ma non viene effetuato alcun controllo
# @return $v0:	 File descriptor. Positivo se non ci sono problemi, negativo in caso di errori. 

		li   $v0, SYS_OPEN_FILE       
		move   $a0, %filename 
		li   $a1, %mode  
		li   $a2, 0 # Argomento ignorato in MARS
		syscall     
.end_macro
#######################################################################################################################
.macro read_file (%file_descriptor, %buffer, %buffer_length)
# Macro per leggere un file gia' aperto in lettura tramite open_file
#
# @arg file_descriptor: Registro contenente l'output di open_file
# @arg buffer:		Indirizzo contenete il buffer dove memorizzare i dati letti dal file
# @arg buffer_length:	Immediato che indica la dimensione del buffer (in byte)
# @return $v0:		
#		- Numero di caratteri letti, se non ci sono problemi
#		- 0, se EOF
#		- Numero negativo, in caso di errori

 	li   $v0, SYS_READ_FILE       
	move $a0, %file_descriptor      
	la   $a1, %buffer   
	li   $a2, %buffer_length     
	syscall            
 .end_macro
#######################################################################################################################
.macro write_file (%file_descriptor, %data, %data_length)
# Macro per leggere un file gia' aperto in scrittura tramite open_file
#
# @arg file_descriptor: Registro contenente l'output di open_file
# @arg data			: Stringa  da scrivere
# @arg data_length	: Immediato che indica quanti byte scrivere
# @return $v0:		
#		- Numero di caratteri scritti, se non ci sono problemi
#		- Numero negativo, in caso di errori
	.data
		data: .asciiz %data
	.text
 	li   $v0, SYS_WRITE_FILE       
	move $a0, %file_descriptor      
	la   $a1, data   
	li   $a2, %data_length     
	syscall            
 .end_macro
 #######################################################################################################################
.macro write_file_reg (%file_descriptor, %data, %data_length)
# Macro per leggere un file gia' aperto in scrittura tramite open_file
#
# @arg file_descriptor: Registro contenente l'output di open_file
# @arg data			: Registro contenete i dati da scrivere
# @arg data_length	: Immediato che indica quanti byte scrivere
# @return $v0:		
#		- Numero di caratteri scritti, se non ci sono problemi
#		- Numero negativo, in caso di errori

 	li   $v0, SYS_WRITE_FILE       
	move $a0, %file_descriptor      
	move   $a1, %data   
	li   $a2, %data_length     
	syscall            
 .end_macro
 #######################################################################################################################
.macro write_file_label (%file_descriptor, %data, %data_length)
# Macro per leggere un file gia' aperto in scrittura tramite open_file
#
# @arg file_descriptor: Registro contenente l'output di open_file
# @arg data			: label contenete i dati da scrivere
# @arg data_length	: Immediato che indica quanti byte scrivere
# @return $v0:		
#		- Numero di caratteri scritti, se non ci sono problemi
#		- Numero negativo, in caso di errori

 	li   $v0, SYS_WRITE_FILE       
	move $a0, %file_descriptor      
	la  $a1, %data   
	li   $a2, %data_length     
	syscall            
 .end_macro
#######################################################################################################################
.macro close_file (%file_descriptor)
	li   $v0, SYS_CLOSE_FILE       
	move $a0, %file_descriptor
	syscall            
.end_macro
#######################################################################################################################
.macro next_digit (%file_descriptor)
	move $a0 %file_descriptor
	jal nextDigit
.end_macro
#######################################################################################################################
