.data
.include "abertura_gauntlet.s"
	LEN_BEGINING: .word 32
	BEGINING: 67,217,67,435,67,435,67,1305,69,217,65,1305,65,435,59,217,65,435,65,217,64,217,67,435,59,217,60,435,67,217,67,217,67,217,67,217,67,217,67,435,67,1305,69,217,65,1305,65,435,59,217,65,435,65,435,65,435,67,217,64,217,62,217,60,652

	LEN_BRIDGE: .word 81
	BRIDGE :4,216,62,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,216,64,216,64,216,62,216,64,216,62,432,65,432,65,216,65,432,65,648,67,216,71,216,76,648,74,216,72,1728,71,432,67,216,71,216,76,648,74,216,71,1728,67,432,67,216,71,216,76,648,74,216,72,1728,71,432,67,216,71,216,76,648,74,216,71,1728,67,432,67,216,71,216,76,648,74,216,72,216


	LEN_CHORUS: .word 67
	CHORUS: 72,435,72,435,72,217,71,217,72,217,71,652,65,217,67,435,69,652,71,435,71,435,71,217,67,217,71,217,67,652,60,217,62,435,64,652,72,435,72,435,72,217,71,217,72,217,71,652,65,217,67,435,69,435,69,217,71,217,67,217,71,435,71,217,67,217,71,217,67,435,60,435,62,435,64,652,72,435,72,435,72,217,71,217,72,217,74,435,74,435,74,1087,71,435,71,435,71,435,71,217,69,217,69,217,67,652,67,217,67,217,67,217,67,1305,69,435,65,1304,65,217,65,217,64,217,62,217,62,652,67,435,62,217,64,1522
	ENTER: .byte 0x0D


.text
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0x07070707	# cor vermelho|vermelho|vermelhor|vermelho
LOOP: 	beq t1,t2,FORA		# Se for o �ltimo endere�o ent�o sai do loop
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	j LOOP			# volta a verificar


# Carrega a imagem1
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,abertura_gauntlet		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP1: 	beq t1,t2,FORA1		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP1			# volta a verificar


# Carrega a imagem2
FORA1:	li t1,0xFF100000	# endereco inicial da Memoria VGA - Frame 1
	li t2,0xFF112C00	# endereco final 
	la s1,abertura_gauntlet		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP2: 	beq t1,t2,end_loop		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP2			# volta a verificar
	
end_loop:	j MUSICA
	
PRESS_ENTER:
	la s4, ENTER
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero, RET  	   	# Se n�o h� tecla pressionada ent�o vai para FIM
	bne t0, zero, FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	sw t2,12(t1)  			# escreve a tecla pressionada no display
	RET:	ret
		


MUSICA	:		
INICIO_:
	la s0, LEN_BEGINING		
	lw s1,0(s0)		
	la s0,BEGINING		
	li t0,0			
	li a2,68		
	li a3,127
	

LOOP_0:
	beq t0,s1, MEIO_		
	lw a0,0(s0)
	lw a1,4(s0)
	li a7,31	 
	ecall			
	mv a0,a1		
	li a7,32		 
	ecall	
	jal PRESS_ENTER	
	addi s0,s0,8	
	addi t0,t0,1		
	j LOOP_0			
MEIO_:
	la s0, LEN_BRIDGE		# define o endere�o do n�mero de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,BRIDGE		# define o endere�o das notas
	li t0,0			# zera o contador de notas
	li a2,68		# define o instrumento
	li a3,127
LOOP_1:
	beq t0,s1, FIM_		# contador chegou no final? ent�o  v� para FIM
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	jal PRESS_ENTER	
	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP_1
	
FIM_:
	la s0, LEN_CHORUS		# define o endere�o do n�mero de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,CHORUS		# define o endere�o das notas
	li t0,0			# zera o contador de notas
	li a2,68		# define o instrumento
	li a3,127
LOOP_2:
	beq t0,s1, EXIT		# contador chegou no final? ent�o  v� para FIM
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	jal PRESS_ENTER	
	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP2	
EXIT:	
j INICIO_	
	
# devolve o controle ao sistema operacional
FIM:	li a7,10		# syscall de exit
	ecall
