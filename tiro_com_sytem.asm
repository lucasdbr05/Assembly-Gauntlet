.data
POSICAO_PERSONAGEM: .half 160,80
POSICAO_TIRO: .half 160,80
ANTIGA_POSICAO_PERSONAGEM: .half 0,0
POSICAO_FINAL_TIRO:.half 0,0
DIR_PERSONAGEM : .byte ' '

.include "block.s"
.include "black.s"
.include "tiro.data"
.include "black_block.s"
.include "erase_tiro.s"
.include "../MACROSv21.s"





.text

FUNDO:  ###DEFINE O FUNDO COMO TODO PRETO
	la a0, black
	li a1, 0
	li a2, 0
	li a3, 0   #FUNDO NO FRAME 0
	call PRINT
	li a3, 1
	call PRINT  #FUNDO NO FRAME 1
	
	
GAME_LOOP:
	call INPUT #PROCEDIMENTO QUE CHECA SE HÁ ALGUM BOTÃO QUE FOI APERTADO
	 #s0: frame a ser escolhido
	xori s0, s0, 1  #modifica os frames ente 0 e 1
	
	la t0, POSICAO_PERSONAGEM  
	la a0, bloco   #imagem a ser carregada
	lh a1, 0(t0)   #posição x do personagem
	lh a2, 2(t0)    #posição y do personagem
	mv a3, s0        #frame
	call PRINT      #printa o personagem no bitmap
	
	#Seleciona o frame do bitmap display a ser usado
	li t0, 0xFF200604
	sw s0, 0(t0)
	
	
	#Apaga o rastro da posição antiga do personagem no bitmap display no frame seguinte ao do movimento
	#Esse apagamento se dá sobrepondo a coloração de fundo sobre o rastro do personagem antes do movimento
	la t0, ANTIGA_POSICAO_PERSONAGEM
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	
	
	xori a3, a3,1
	
	call PRINT
	
	j GAME_LOOP
	
	

	#Recebe a entrada do usuario
	INPUT:
	li t1, 0xFF200000  #Endereço do keyboard
	lw t0, 0(t1)      
	andi t0, t0, 0x0001  #Mascara o bit menos significativo
	beq t0, zero, CONTINUE    #Se não tiver sido apertado nada, pula para continue
	lw t2, 4(t1)    #em t2 está o ascii da tecla que foi apertada
	
		
	li t0, 'w'
	beq t2, t0, MOVE_UP #move para cima
	li t0, 'a'
	beq t2, t0, MOVE_LEFT  #move para esquerda
	li t0, 's'
	beq t2, t0, MOVE_DOWN   #move para  baixo
	li t0, 'd'
	beq t2, t0, MOVE_RIGHT   #move para	 direita
	li t0, 'l'
	beq t2, t0, ATTACK
	
	
CONTINUE: ret	

MOVE_LEFT:
	la t6, DIR_PERSONAGEM
	li t0, 'a'
	sb t0, 0(t6)
	
	
	la t0, POSICAO_PERSONAGEM  #
	la t1, ANTIGA_POSICAO_PERSONAGEM
	lw t2, 0(t0)
	sw t2, 0(t1) #Atualiza a antiga posição do perosnagem
	
	la t0, POSICAO_PERSONAGEM
	lh t1, 0(t0)  
	addi t1, t1, -16
	blt t1, zero, CONTINUE
	sh t1, 0(t0)    #Atualiza a nova posiçao do perosnagem
	ret
MOVE_RIGHT:
	la t6, DIR_PERSONAGEM
	li t0, 'd'
	sb t0, 0(t6)
	la t0, POSICAO_PERSONAGEM
	la t1, ANTIGA_POSICAO_PERSONAGEM
	lw t2, 0(t0)
	sw t2, 0(t1)#Atualiza a antiga posição do perosnagem
	
	la t0, POSICAO_PERSONAGEM
	lh t1, 0(t0)
	li t2, 320
	addi t1, t1, 16
	bge t1, t2, CONTINUE
	sh t1, 0(t0)#Atualiza a nova posiçao do perosnagem
	ret
MOVE_UP:
	la t6, DIR_PERSONAGEM
	li t0, 'w'
	sb t0, 0(t6)

	la t0, POSICAO_PERSONAGEM
	la t1, ANTIGA_POSICAO_PERSONAGEM
	lw t2, 0(t0)
	sw t2, 0(t1)#Atualiza a antiga posição do perosnagem
	
	la t0, POSICAO_PERSONAGEM
	lh t1, 2(t0)
	addi t1, t1, -16
	blt t1, zero, CONTINUE
	sh t1, 2(t0)   #Atualiza a nova posiçao do perosnagem
	ret
MOVE_DOWN:
	la t6, DIR_PERSONAGEM
	li t0, 's'
	sb t0, 0(t6)
	la t0, POSICAO_PERSONAGEM
	la t1, ANTIGA_POSICAO_PERSONAGEM
	lw t2, 0(t0)
	sw t2, 0(t1)#Atualiza a antiga posição do perosnagem
	
	la t0, POSICAO_PERSONAGEM
	lh t1, 2(t0)
	li t2, 240
	addi t1, t1, 16
	bge t1, t2, CONTINUE
	sh t1, 2(t0)    #Atualiza a nova posiçao do perosnagem
	ret

ATTACK:
	#Atualiza posicao inicial do tiro
	la t0, POSICAO_PERSONAGEM
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t0, POSICAO_TIRO
	sh t1, 0(t0)
	sh t2, 2(t0)
	
	la t0, DIR_PERSONAGEM
	lb t5, 0(t0)
	li t1, 'w'
	beq t5, t1, ATT_UP
	li t1, 's'
	beq t5, t1, ATT_DOWN
	li t1,'d'
	beq t5, t1, ATT_RIGHT
	li t1, 'a'
	beq t5, t1, ATT_LEFT
	ret
		
	
	
		
		ATT_DOWN:
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		li t0, 240
		LOOP_ATT_DOWN:
		bge a3, t0, END_LOOP_ATT_DOWN
		addi a3, a3, 4
		j LOOP_ATT_DOWN
		END_LOOP_ATT_DOWN:
		li a4, 0x38
		mv a5, s3
		li a7, 47
		ecall
		li t0, 10000
		LOOP_ERASE_LASER_DOWN:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_DOWN
		li a4, 0x000
		li a7,47
		ecall
		ret
		
		ATT_UP:
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		LOOP_ATT_UP:
		ble a3, zero, END_LOOP_ATT_UP
		addi a3, a3, -4
		j LOOP_ATT_UP
		END_LOOP_ATT_UP:
		li a4, 0x38
		mv a5, s3
		li a7, 47
		ecall
		
		li t0, 10000
		LOOP_ERASE_LASER_UP:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_UP
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		LOOP_ERASE_UP:
		ble a3, zero, END_LOOP_ERASE_UP
		addi a3, a3, -4
		j LOOP_ERASE_UP
		END_LOOP_ERASE_UP:
		li a4, 0x000
		mv a5, s3
		li a7, 47
		ecall
		ret
		
		ATT_RIGHT:
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		li t0, 320
		mv a2, a0
		LOOP_ATT_RIGHT:
		bge a2, t0, END_LOOP_ATT_RIGHT
		addi a2, a2, 4
		j LOOP_ATT_RIGHT
		END_LOOP_ATT_RIGHT:
		mv a3,  a1
		li a4, 0x38
		mv a5, s3
		li a7, 47
		ecall
		li t0, 10000
		LOOP_ERASE_LASER_RIGHT:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_RIGHT
		li a4, 0x000
		li a7,47
		ecall
		ret
		
		ATT_LEFT:
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		LOOP_ATT_LEFT:
		ble a2, zero, END_LOOP_ATT_LEFT
		addi a2, a2, -4
		j LOOP_ATT_LEFT
		END_LOOP_ATT_LEFT:
		mv a3,  a1
		li a4, 0x38
		mv a5, s3
		li a7, 47
		ecall
		li t0, 10000
		LOOP_ERASE_LASER_LEFT:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_LEFT
		la t0,POSICAO_PERSONAGEM
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		LOOP_ERASE_LEFT:
		ble a2, zero, END_LOOP_ERASE_LEFT
		addi a2, a2, -4
		j LOOP_ERASE_LEFT
		END_LOOP_ERASE_LEFT:
		mv a3,  a1
		li a4, 0x00
		mv a5, s3
		li a7, 47
		ecall
		ret
ret	





#a0 = endereco_imagem
#a1 = x
#a2 = y
#a3 = frame
#t0 = endereco_bitmap_diplay
#t1 = enderco da imagem
#t2 = contador linha
#t3 = contador coluna
#t4 = largura
#t5 = altura

PRINT:
	
	
	li t0, 0xFF0   #Endereçõ do bimap display 
	add t0, t0, a3  #Define se é o frame 1 ou frame 0
	slli t0, t0, 20  #Adiciona os 5 0's que faltam (0xFF000000 ou 0xFF100000)
	
##########Vai para a posição do personagem########
#Para isso faz o seguinte calculo:
#Posição x: endereço do bitmap + x = t0 + a1
#Posição y: 320*y + x = 320*a2 + t0
	add t0, t0, a1   
	
	li t1, 320
	mul t1, t1, a2   
	add t0, t0, t1
###########################################	
	addi t1, a0, 8 #Endereço do primeiro byte da imagem
	
	mv t2, zero  #Contador de linha
	mv t3, zero  #Contador de coluna
	
	
	lw t4, 0(a0)  #Largura
	lw t5, 4(a0)   #Altura
	
	
PRINT.Line:
         #Loop que desenha linha por linha da imagem
	lw t6, 0(t1)
	sw t6, 0(t0)
	
	addi t0, t0, 4
	addi t1, t1, 4
	
	addi  t3, t3, 4
	blt t3, t4, PRINT.Line
	
	addi t0, t0, 320
	sub t0, t0,t4
	
	mv t3, zero
	addi t2, t2, 1
	
	blt t2, t5, PRINT.Line
BREAK:	ret
	
PRINT_TIRO:

	
	
	li t0, 0xFF0   #Endereçõ do bimap display 
	add t0, t0, a3  #Define se é o frame 1 ou frame 0
	slli t0, t0, 20  #Adiciona os 5 0's que faltam (0xFF000000 ou 0xFF100000)
	
##########Vai para a posição do personagem########
#Para isso faz o seguinte calculo:
#Posição x: endereço do bitmap + x = t0 + a1
#Posição y: 320*y + x = 320*a2 + t0
	add t0, t0, a1   
	
	li t1, 320
	mul t1, t1, a2   
	add t0, t0, t1
###########################################	
	addi t1, a0, 8 #Endereço do primeiro byte da imagem
	
	mv t2, zero  #Contador de linha
	mv t3, zero  #Contador de coluna
	
	
	lw t4, 0(a0)  #Largura
	lw t5, 4(a0)   #Altura
	
	
PRINT_TIRO.Line:
         #Loop que desenha linha por linha da imagem
	lw t6, 0(t1)
	sw t6, 0(t0)
	
	addi t0, t0, 4
	addi t1, t1, 4
	
	call CHECK_WALLS
	
	addi  t3, t3, 4
	blt t3, t4, PRINT.Line
	
	addi t0, t0, 320
	sub t0, t0,t4
	
	mv t3, zero
	addi t2, t2, 1
	
	blt t2, t5, PRINT.Line
	ret

	
	
		
.include "../SYSTEMv21.s"	
