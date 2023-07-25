.data

FASE_2: .string "FASE 2"

POSICAO_PERSONAGEM: .half 32,22
ANTIGA_POSICAO_PERSONAGEM: .half 160,80
sprite: .word 0x00000000
DIR_PERSONAGEM : .byte 'd'

KEY_POSITION: .half 48, 200
CAUGHT_KEY: .byte 0
CAUGHT_KEY_AUX: .byte 0
FST_TIME_CAUGHT:.byte 0




POSICAO_TIRO: .half 0,0
ANTIGA_POSICAO_TIRO:.half 0,0



POSICAO_PORTAL: .half 64,140

LIFE_MSG: .string "LIFE: "
LIFE: .byte 5

PONTOS_MSG: .string "SCORE: " 
PONTOS: .word 10000



##### ATIRADOR 1######
POSICAO_ATIRADOR_1: .half 56,12
POSICAO_TIRO1_A1: .half 64,32,1
ANTIGA_POSICAO_TIRO1_A1: .half 108,36
POSICAO_TIRO2_A1: .half 64,32,0
ANTIGA_POSICAO_TIRO2_A1: .half 108,36
VIDAS_A1:.string "ATIRADOR 1:"
ATIRADOR_1_VIVO: .byte 5
LIMIT_A1:.half 106
##########

##### ATIRADOR 2######
POSICAO_ATIRADOR_2: .half 8,64   ##120, 164
POSICAO_TIRO1_A2: .half 32,64,1
ANTIGA_POSICAO_TIRO1_A2: .half 108,36
POSICAO_TIRO2_A2: .half 32,64,0
ANTIGA_POSICAO_TIRO2_A2: .half 108,36
VIDAS_A2:.string "ATIRADOR 2:"
ATIRADOR_2_VIVO: .byte 5
LIMIT_A2:.half 164
##########

#####ATIRADOR 3######
POSICAO_ATIRADOR_3: .half 92,164
POSICAO_TIRO1_A3: .half 88,172,1
ANTIGA_POSICAO_TIRO1_A3: .half 108,36
POSICAO_TIRO2_A3: .half 88,172,0
ANTIGA_POSICAO_TIRO2_A3: .half 108,36
VIDAS_A3:.string "ATIRADOR 3:"
ATIRADOR_3_VIVO: .byte 5
LIMIT_A3:.word 88
##########
TIMER_F2: .word 0x0006F4
CURRENT_CHECKED_TIRO:.byte 0
CURRENT_CHECKED_AT: .byte 0


.include "block.s"
.include "tiro.data"
.include "black_block.s"
.include "erase_tiro.data"
.include "sprite16x16.data"
.include "mapa_2.data"
.include "matrix2.data"
.include "ghost_gate.data"
.include "MACROSv21.s"
.include "sprites/chave.data"
.include "sprites/personagem_direita.data"
.include "sprites/personagem_esquerda.data"
.include "sprites/personagem_frente.data"
.include "sprites/personagem_costas.data"
.include "sprites/porta.data"
.include "sprites/sf.data"
.include "sprites/inimigo_baixo.data"
.include "sprites/inimigo_cima.data"
.include "sprites/inimigo_direita.data"
.include "sprites/inimigo_esquerda.data"
.include "sprites/pele.data"


__FASE_2__:
.text
	
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0x07070707	# cor vermelho|vermelho|vermelhor|vermelho
	LOOP_1C: 	
	beq t1,t2,FORA_1C		# Se for o �ltimo endere�o ent�o sai do loop
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	j LOOP_1C	# volta a verificar
	FORA_1C:
	la a0, mapa_2
	li a1, 0
	li a2, 0
	li a3, 0   #FUNDO NO FRAME 0
	call PRINT
	li a3, 1
	call PRINT  #FUNDO NO FRAME 1
	li a0, 75
	li a1, 4500
	li a2, 96
	li a3, 120
	li a7, 33
	ecall
	li a7,104
	la a0,FASE_2
	li a1,240
	li a2,50
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0,FASE_2
	li a1,240
	li a2,50
	li a3,0x0038
	li a4,1
	ecall
	
	li a7,104
	la a0,LIFE_MSG
	li a1,220
	li a2,70
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0,LIFE_MSG
	li a1,220
	li a2,70
	li a3,0x0038
	li a4,1
	ecall
	
	la t1,LIFE
	lb t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,70
	li a3,0x0038
	li a4,0
	ecall
	
	la t1,LIFE
	lb t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,70
	li a3,0x0038
	li a4,1
	ecall
	
	
	li a7,104
	la a0, PONTOS_MSG
	li a1,220
	li a2,90
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0, PONTOS_MSG
	li a1,220
	li a2,90
	li a3,0x0038
	li a4,1
	ecall
	
	la t1,PONTOS
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,90
	li a3,0x0038
	li a4,0
	ecall
	
	la t1, PONTOS
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,90
	li a3,0x0038
	li a4,1
	ecall
	
	la t1,VIDAS_A1
	lw t0, 0(t1)
	li a7,105
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,0
	#ecall
	
	la t1, VIDAS_A1
	lw t0, 0(t1)
	li a7,105
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,1
	#ecall
	
	la t1,VIDAS_A2
	lw t0, 0(t1)
	li a7,105
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,0
	#ecall
	
	la t1, VIDAS_A2
	lw t0, 0(t1)
	li a7,105
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,1
	#ecall
	
	la t1,VIDAS_A3
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,0
	#ecall
	
	la t1, VIDAS_A3
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,110
	li a3,0x0038
	li a4,1
	#ecall
	
	SETUP_PERS:
	la t0, POSICAO_ATIRADOR_1
	la a0, inimigo_baixo
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	
	la t0, POSICAO_ATIRADOR_2
	la a0, inimigo_direita
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	
	la t0, POSICAO_ATIRADOR_3
	la a0, inimigo_esquerda
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	
	j GAME_LOOP
	RESTAURA_VIDA:
	li t1, 5
	la t0, ATIRADOR_1_VIVO
	sb t1, 0(t0)
	la t0, ATIRADOR_2_VIVO
	sb t1, 0(t0)
	la t0, ATIRADOR_3_VIVO
	sb t1, 0(t0)
	ret
	COUNTER_LIFES:

	

GAME_LOOP:
######## TEMPORIZADOR #######
	la t1, TIMER_F2
	lw t0, 0(t1)
	addi t0, t0, -1
	sw t0, 0(t1)
	bgt t0, zero, JUMP_TIMER
	
	li t2, 0x06F4
	sw t2, 0(t1)
	la t0, LIFE
	lb t1, 0(t0)
	addi t1, t1, -1
	sb t1, 0(t0)
	JUMP_TIMER:
###########
	
	
	call INPUT #PROCEDIMENTO QUE CHECA SE HÁ ALGUM BOTÃO QUE FOI APERTADO
	 #s0: frame a ser escolhido
	
	####### DIRECAO DA SPRITE DO PERSONAGEM ######	
	la t1, DIR_PERSONAGEM
	lb t2, 0(t1)
	li t0, 'w'
	beq t2, t0, DIR_S_UP #move para cima
	li t0, 'a'
	beq t2, t0, DIR_S_LEFT  #move para esquerda
	li t0, 's'
	beq t2, t0,  DIR_S_DOWN   #move para  baixo
	li t0, 'd'
	beq t2, t0,  DIR_S_RIGHT   #move para	 direit
	
	
	DIR_S_UP:
	la t1, sprite
	la t2, personagem_up
	sw t2, 0(t1)
	j END_DIRS
	DIR_S_DOWN:
	la t1, sprite
	la t2, personagem_down
	sw t2, 0(t1)
	j END_DIRS
	DIR_S_LEFT:
	la t1, sprite
	la t2, personagem_left
	sw t2, 0(t1)
	j END_DIRS
	DIR_S_RIGHT:
	la t1, sprite
	la t2, personagem_right
	sw t2, 0(t1)
	j END_DIRS
	
	END_DIRS:
	#########
	
	
	
	
	
	 la t1,PONTOS
	lw t0, 0(t1)
	addi t0, t0, -1
	sw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,90
	li a3,0x0038
	li a4,0
	ecall
	
	
	
	 
	
	
	 la t1,PONTOS
	lw t0, 0(t1)
	addi t0, t0, -1
	sw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,90
	li a3,0x0038
	li a4,1
	ecall
	
	
	la t1,LIFE
	lb t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,70
	li a3,0x0038
	li a4,1
	ecall
	la t1,LIFE
	lb t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,70
	li a3,0x0038
	li a4, 0
	ecall
	
	
	
	
	
	 
	xori s0, s0, 1  #modifica os frames ente 0 e 1
	
	la t0, POSICAO_PERSONAGEM  
	la t2, sprite
	lw a0, 0(t2)  #imagem a ser carregada
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
	
	
	
##### ATIRA #######	
	call ATIRA_T2A1
	ATIROU_T2A1:
	call ATIRA_T1A1
	ATIROU_T1A1:
	call ATIRA_T2A2
	ATIROU_T2A2:
	call ATIRA_T1A2
	ATIROU_T1A2:
	call ATIRA_T2A3
	ATIROU_T2A3:
	call ATIRA_T1A3
	ATIROU_T1A3:
	call PONTO_0
#################################
	
	la t1, CAUGHT_KEY
	lb t0, 0(t1)
	bne zero,t0, Check_Has_KEY
	la t0, KEY_POSITION
	la a0, key
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	
	
	xori a3, a3,1
	call PRINT
	j GAME_LOOP
	Check_Has_KEY:
	
	######
	#la t0, POSICAO_ATIRADOR_2
	la a0, black_block
	li a1, 8
	li a2, 64
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	#la t0, POSICAO_ATIRADOR_3
	la a0, black_block
	li a1, 92
	li a2,164
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	#######
	la t0, CAUGHT_KEY_AUX
	lb t1, 0(t0)
	bne zero, t1, Has_Key

	li t2, 1
	sb t2, 0(t0)
	la t0, KEY_POSITION
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3,0
	
	call PRINT

	li t1, 120
	li t2, 64
	la t0, KEY_POSITION
	sh t1, 0(t0)
	sh t2, 2(t0)
	la t0, CAUGHT_KEY
	sb zero, 0(t0)
	
	#####
	call RESTAURA_VIDA
	
	la t0, POSICAO_ATIRADOR_2
	li t1, 204
	sh t1, 2(t0)
	
	la t0, POSICAO_ATIRADOR_3
	li t1, 96
	sh t1, 2(t0)
	la t0, POSICAO_TIRO1_A2
	la t2, POSICAO_TIRO2_A2
	li t1, 204
	sh t1, 2(t0)
	sh t1, 2(t2)
	la t0, POSICAO_TIRO1_A3
	la t2, POSICAO_TIRO2_A3
	li t1, 102
	sh t1, 2(t0)
	sh t1, 2(t2)
	
	#####
	la t0, LIMIT_A1
	li t1,180
	sh t1, 0(t0)
	#la t0, POSICAO_ATIRADOR_2
	la a0, inimigo_direita
	li a1, 8
	li a2, 204
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	#la t0, POSICAO_ATIRADOR_3
	la a0, inimigo_esquerda
	li a1, 92
	li a2, 96
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	li a0, 61
	li a1, 1300
	li a2, 88
	li a3, 110
	li a7, 33
	ecall
	j GAME_LOOP
	Has_Key:
	la t0, KEY_POSITION
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	
	xori a3, a3,1
	call PRINT
	
	la t0, POSICAO_PORTAL
	la a0, portal
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	
	call PRINT
	
	call CHECK_IF_ARRIVED_DOOR

	
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
	beq t2, t0, MOVE_RIGHT   #move para	 direit
	li t0, 'k'
	beq t2, t0, TIRO
	
		
	
	
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
	
	#####
	######ebreak
	lh t4, 0(t0)  #t0: posicao do ersonagem
	lh t5, 2(t0)
	li t3, 320
	mul t5, t5, t3
	add t4, t4, t5
	la t6, matrix_test_2
	add t6, t4, t6
	li t2, 16
	li t3, 16
	LOOP_CHECK_LEFT:
	
	addi t2, t2, -2
	addi t6, t6, -2
	lb t4, 0(t6)
	bne t4, zero, CONTINUE
	blt t3, zero, end_loop_left
	bgt t2, zero, LOOP_CHECK_LEFT
	check_left:
		addi t3, t3, -1
		li t2, 16
		addi t6, t6, 336
		bgt t3, zero, LOOP_CHECK_LEFT
	
	end_loop_left:	
	#####
	sh t1, 0(t0)    #Atualiza a nova posiçao do perosnagem
	
	la t0, CAUGHT_KEY
	lb t1, 0(t0)
	bne zero, t1, end_check_key_ml
	la t0, POSICAO_PERSONAGEM
	la t1, KEY_POSITION
	
	lh t2, 0(t0)
	lh t3, 0(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a1, t5
	lh t2, 2(t0)
	lh t3, 2(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a0, t5
	
	and a0, a0, a1
	
	beq zero, a0, end_check_key_ml
	la t0, CAUGHT_KEY
	sb t5, 0(t0)
	
	
	end_check_key_ml:
	
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
	
	######ebreak
	lh t4, 0(t0)  #t0: posicao do ersonagem
	lh t5, 2(t0)
	li t3, 320
	mul t5, t5, t3
	add t4, t4, t5
	la t6, matrix_test_2
	add t6, t4, t6
	addi t6, t6, 16 
	li t2, 16
	li t3, 16
	LOOP_CHECK_RIGHT:
	
	addi t2, t2, -2
	addi t6, t6, 2
	lb t4, 0(t6)
	bne t4, zero, CONTINUE
	blt t3, zero, end_loop_right
	bgt t2, zero, LOOP_CHECK_RIGHT
	check_right:
		addi t3, t3, -1
		li t2, 16
		addi t6, t6, 304
		bgt t3, zero, LOOP_CHECK_RIGHT
	
	end_loop_right:	
	
	
	sh t1, 0(t0)#Atualiza a nova posiçao do perosnagem
	
	la t0, CAUGHT_KEY
	lb t1, 0(t0)
	bne zero, t1, end_check_key_mr
	la t0, POSICAO_PERSONAGEM
	la t1, KEY_POSITION
	
	lh t2, 0(t0)
	lh t3, 0(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a1, t5
	lh t2, 2(t0)
	lh t3, 2(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a0, t5
	
	and a0, a0, a1
	
	beq zero, a0, end_check_key_mr
	la t0, CAUGHT_KEY
	sb t5, 0(t0)
	
	
	end_check_key_mr:
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
	
	#####ebreak
	lh t4, 0(t0)  
	lh t5, 2(t0)
	li t3, 320
	addi t5, t5, -16
	mul t5, t5, t3
	add t4, t4, t5
	la t6, matrix_test_2
	add t6, t4, t6
	li t2, 16
	li t3, 16
	LOOP_CHECK_UP:
	addi t2, t2, -2
	addi t6, t6, 2
	lb t4, 0(t6)
	bne t4, zero, CONTINUE
	blt t3, zero, end_loop_up
	bgt t2, zero, LOOP_CHECK_UP
	check_up:
		addi t3, t3, -1
		li t2, 16
		addi t6, t6, 304
		bgt t3, zero, LOOP_CHECK_UP
	
	end_loop_up:
	sh t1, 2(t0)   #Atualiza a nova posiçao do perosnagem
	
	la t0, CAUGHT_KEY
	lb t1, 0(t0)
	bne zero, t1, end_check_key_mu
	la t0, POSICAO_PERSONAGEM
	la t1, KEY_POSITION
	
	lh t2, 0(t0)
	lh t3, 0(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a1, t5
	lh t2, 2(t0)
	lh t3, 2(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a0, t5
	
	and a0, a0, a1
	
	beq zero, a0, end_check_key_mu
	la t0, CAUGHT_KEY
	sb t5, 0(t0)
	
	
	end_check_key_mu:
	
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
	
	######ebreak
	lh t4, 0(t0)  
	lh t5, 2(t0)
	li t3, 320
	addi t5, t5, 16
	addi t5, t5, 1
	mul t5, t5, t3
	add t4, t4, t5
	la t6, matrix_test_2
	add t6, t4, t6
	li t2, 16
	li t3, 16
	LOOP_CHECK_DOWN:
	
	addi t2, t2, -2
	addi t6, t6, 2
	lb t4, 0(t6)
	bne t4, zero, CONTINUE
	blt t3, zero, end_loop_down
	bgt t2, zero, LOOP_CHECK_DOWN
	check_down:
		addi t3, t3, -1
		li t2, 16
		addi t6, t6, 304
		bgt t3, zero, LOOP_CHECK_DOWN
	
	end_loop_down:	
	sh t1, 2(t0)    #Atualiza a nova posiçao do perosnagem
	
	la t0, CAUGHT_KEY
	lb t1, 0(t0)
	bne zero, t1, end_check_key_md
	la t0, POSICAO_PERSONAGEM
	la t1, KEY_POSITION
	
	lh t2, 0(t0)
	lh t3, 0(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a1, t5
	lh t2, 2(t0)
	lh t3, 2(t1)
	addi t2, t2, -1
	slt t5, t2, t3
	addi t2, t2, 17
	slt t6, t3, t2
	and t5, t5, t6
	addi t2, t2, -17
	slt t6, t2, t3
	addi t3, t3, 8
	addi t2, t2, 17
	slt t4, t3, t2
	and t4, t6, t4
	or t5, t5, t4
	
	mv a0, t5
	
	and a0, a0, a1
	
	beq zero, a0, end_check_key_md
	la t0, CAUGHT_KEY
	sb t5, 0(t0)
	
	
	end_check_key_md:
	
	ret

	

	
AUX_GAME_LOOP: j GAME_LOOP
####APERTA K
TIRO:
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
	beq t5, t1, TIRO_UP
	li t1, 's'
	beq t5, t1, TIRO_DOWN
	li t1,'d'
	beq t5, t1, TIRO_RIGHT
	li t1, 'a'
	beq t5, t1, TIRO_LEFT
	
	ret
		
	
	
		################################
		TIRO_UP:
		#ebreak
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, -4
		sh a2, 2(a0)
		lh a1, 0(a0)
		addi a1, a1, 8
		sh a1, 0(a0)
		LOOP_PRINT_TIRO_UP:
			la t0, POSICAO_TIRO
			lh t4, 0(t0)
			lh t5, 2(t0)
			li t3, 320
			addi t5, t5, -4
			mul t5, t5, t3
			add t4, t4, t5
			la t6, matrix_test_2
			add t6, t6, t4
			li t2, 4
			li t3, 4
			loop_check_tiro_up:
				addi t2, t2, -1
				addi t6, t6, 1
				lb t4,0(t6)
				bne t4, zero, GAME_LOOP
				blt t3, zero, end_loop_check_tiro_up
				bgt t2, zero, loop_check_tiro_up
				check_end_up:
				addi t3, t3, -1
				li t2, 4
				addi t6, t6, 304
				bgt t3, zero, loop_check_tiro_up
			end_loop_check_tiro_up:
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, -4
		sh a2, 2(a0)
		lh a1, 0(a0)
		la a0, tiro
		xori a3, a3,1
		
		call PRINT
		
		li a0,12  
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		call PRINT
		li t0, 16
		blt a2, t0, GAME_LOOP
		
		la t0, CURRENT_CHECKED_AT
		li t1, 1
		li t5, 1
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 2
		li t5, 2
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 3
		li t5, 3
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		
		j  LOOP_PRINT_TIRO_UP
		END_TIRO_UP: ret
		
	
		
		################################	
		TIRO_DOWN:
		#ebreak
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, 20
		sh a2, 2(a0)
		lh a1, 0(a0)
		addi a1, a1, 8
		sh a1, 0(a0)
		LOOP_PRINT_TIRO_DOWN:
			la t0, POSICAO_TIRO
			lh t4, 0(t0)
			lh t5, 2(t0)
			li t3, 320
			addi t5, t5, 4
			mul t5, t5, t3
			add t4, t4, t5
			la t6, matrix_test_2
			add t6, t4, t6
			li t2, 4
			li t3, 4
			loop_check_tiro_down:
			addi t2, t2, -1
			addi t6, t6, 1
			lb t4, 0(t6)
			bne t4, zero, GAME_LOOP
			blt t3, zero, end_loop_check_tiro_down
			bgt t2, zero, loop_check_tiro_down
				check_end_down:
				addi t3, t3, -1
				li t2, 4
				bgt t3, zero, loop_check_tiro_down
		
			end_loop_check_tiro_down:
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, 4
		sh a2, 2(a0)
		lh a1, 0(a0)
		la a0, tiro
		xori a3, a3,1
		
		call PRINT
		
		li a0,12  
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		call PRINT
		li t0, 210
		bgt a2, t0, GAME_LOOP
		
		la t0, CURRENT_CHECKED_AT
		li t1, 1
		li t5, 1
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 2
		li t5, 2
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 3
		li t5, 3
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		j LOOP_PRINT_TIRO_DOWN
		END_TIRO_DOWN: ret
		
	
	
		################################
		TIRO_RIGHT:
		#ebreak
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		lh a2, 2(a0)
		addi a1, a1, 20
		sh a1, 0(a0)
		addi a2, a2, 8
		sh a2, 2(a0)
		LOOP_PRINT_TIRO_RIGHT:
			la t0, POSICAO_TIRO
			lh t4, 0(t0)
			lh t5, 2(t0)
			li t3, 320
			mul t5, t5, t3
			add t4, t4, t5
			la t6, matrix_test_2
			add t6, t4, t6
			li t2, 4
			li t3, 4
			loop_check_tiro_right:
				addi t2, t2, -1
				addi t6, t6, 1
				lb t4, 0(t6)
				bne t4, zero, GAME_LOOP
				blt t3, zero,end_loop_check_tiro_right
				bgt t2, zero, loop_check_tiro_right
				check_end_right:
					addi t3, t3, -1
					li t2, 4
					addi t6, t6, 316
					bgt t3, zero, loop_check_tiro_right
				
					
				end_loop_check_tiro_right:		
		
		
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		addi a1, a1, 4
		sh a1, 0(a0)
		lh a2, 2(a0)
		la a0, tiro
		xori a3, a3,1
		
		call PRINT
		
		li a0,12 
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		call PRINT
		li t0, 294
		bge a1, t0, GAME_LOOP
		

		la t0, CURRENT_CHECKED_AT
		li t1, 1
		li t5, 1
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 2
		li t5, 2
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 3
		li t5, 3
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		j LOOP_PRINT_TIRO_RIGHT
		END_TIRO_RIGHT: ret
		
		
		################################
		TIRO_LEFT:
		#ebreak
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		addi a1, a1, -4
		sh a1, 0(a0)
		lh a2, 2(a0)
		addi a2, a2, 8
		sh a2, 2(a0)
		LOOP_PRINT_TIRO_LEFT:
			la t0, POSICAO_TIRO
			lh t4, 0(t0)
			lh t5, 2(t0)
			li t3, 320
			mul t5, t5, t3
			add t4, t5, t4
			la t6, matrix_test_2
			add t6, t4, t6
			li t2, 4
			li t3, 4
			loop_check_tiro_left:
				addi t2, t2, -1
				addi t6, t6, -1
				lb t4, 0(t6)
				bne t4, zero, GAME_LOOP
				blt t3, zero, end_loop_check_tiro_left
				bgt t2, zero, loop_check_tiro_left
				check_end_left:
				addi t3, t3, -1
				li t2, 4
				addi t6, t6, 324
				bgt t3, zero, loop_check_tiro_left
			end_loop_check_tiro_left:
			
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		addi a1, a1, -4
		sh a1, 0(a0)
		lh a2, 2(a0)
		la a0, tiro
		xori a3, a3,1
		
		call PRINT
		
		li a0,12
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		call PRINT
		li t0, 16
		blt a1, t0,GAME_LOOP
		
		la t0, CURRENT_CHECKED_AT
		li t1, 1
		li t5, 1
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 2
		li t5, 2
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		li t1, 3
		li t5, 3
		sb t1, 0(t0)
		call CHECK_IF_KILLED_ATIRADOR
		
		
		j LOOP_PRINT_TIRO_LEFT
		END_TIRO_LEFT: ret
ret

CHECK_IF_KILLED_ATIRADOR:

		la t0, CURRENT_CHECKED_AT
		lb t1, 0(t0)
		mv t1, t5
		li t2, 1
		beq t2, t1, IS_A1
		li t2, 2
		beq t2, t1, IS_A2
		li t2, 3
		beq t2, t1, IS_A3
		
		IS_A1:
		la a4, POSICAO_ATIRADOR_1
		la a5, ATIRADOR_1_VIVO
		j INIT_IF_KILLED
		IS_A2:
		la a4, POSICAO_ATIRADOR_2
		la a5, ATIRADOR_2_VIVO
		j INIT_IF_KILLED
		IS_A3:
		la a4, POSICAO_ATIRADOR_3
		la a5, ATIRADOR_3_VIVO
		j INIT_IF_KILLED
		
		
		
		INIT_IF_KILLED:
		mv t0, a5
		lb t1, 0(t0)
		bgt t1, zero, 	CONTINUE_CHECK_IF_KILLED_ATIRADOR
		sb zero, 0(t0)
		ret
	
		CONTINUE_CHECK_IF_KILLED_ATIRADOR:
		mv t0, a4
		la t1, POSICAO_TIRO
		
		lh t2, 0(t0)
		lh t3, 0(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 4
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		
		mv a1, t5
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 4
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		
		mv a0, t5
		
		and a0, a0, a1
		
		#ebreak
		beq zero, a0, END_CHECK_ATIRADOR
		mv t0, a5
		lb t1, 0(t0)
		addi t1, t1, -1
		sb t1, 0(t0)
		bgt t1, zero, GAME_LOOP
		mv t0, a4
		la a0, black_block
		lh a1, 0(t0)
		lh a2, 2(t0)
		li a3,1
		call PRINT
		li a3, 0
		call PRINT
		
								
		j GAME_LOOP
	END_CHECK_ATIRADOR: ret

CHECK_IF_HIT_PERS:
	la t0, CURRENT_CHECKED_TIRO
	lb t1, 0(t0)
	li t2, 1
	beq t1, t2, IS_T1
	li t2, 2
	beq t1, t2, IS_T2
	li t2, 3
	beq t1, t2, IS_T3
	li t2, 4
	beq t1, t2, IS_T4	
	li t2, 5
	beq t1, t2, IS_T5
	li t2, 6
	beq t1, t2, IS_T6
						
	IS_T1:
	la a5, POSICAO_TIRO1_A1	
	j CONTINUE_CHECK_HIT_PERS
	IS_T2:
	la a5, POSICAO_TIRO2_A1	
	j CONTINUE_CHECK_HIT_PERS
	IS_T3:
	la a5, POSICAO_TIRO1_A2	
	j CONTINUE_CHECK_HIT_PERS
	IS_T4:
	la a5, POSICAO_TIRO2_A2
	j CONTINUE_CHECK_HIT_PERS
	IS_T5:
	la a5, POSICAO_TIRO1_A3	
	j CONTINUE_CHECK_HIT_PERS
	IS_T6:
	la a5, POSICAO_TIRO2_A3
	j CONTINUE_CHECK_HIT_PERS
				
	CONTINUE_CHECK_HIT_PERS:
		la t0, POSICAO_PERSONAGEM
		mv t1, a5
		
		lh t2, 0(t0)
		lh t3, 0(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 4
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		mv a1, t5
		
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 4
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		
		mv a0, t5
		
		and a0, a0, a1
		
		
		beq zero, a0, END_CHECK_HIT_TIRO

		la t1, LIFE
		lb t0, 0(t1)
		addi t0, t0, -1
		sb t0, 0(t1)
		beq t0, zero, LOST_GAME
		mv t0, a5
		la a0, erase_tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		mv a3,s0
		
		call PRINT

		mv  t0, a5
		lb t1, 4(t0)
		sb zero, 4(t0) 	
							
		j AUX_GAME_LOOP
	END_CHECK_HIT_TIRO: ret	
	
	PONTO_0:
	la t0, PONTOS
	lw t1, 0(t0)
	ble t1, zero, LOST_GAME	
	ret		
	CHECK_IF_ARRIVED_DOOR:
		la t0, CAUGHT_KEY
		lb t1, 0(t0)
		bne zero, t1, 	CONTINUE_CHECK_IF_ARRIVED_DOOR
		ret
		
		CONTINUE_CHECK_IF_ARRIVED_DOOR:
		
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_PORTAL
		
		lh t2, 0(t0)
		lh t3, 0(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 16
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		mv a1, t5
		
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t2, t2, -1
		slt t5, t2, t3
		addi t2, t2, 17
		slt t6, t3, t2
		and t5, t5, t6
		addi t2, t2, -17
		slt t6, t2, t3
		addi t3, t3, 8
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		
		mv a0, t5
		
		and a0, a0, a1
		
		
		beq zero, a0, END_CHECK_ARRIVED_DOOR
		li a0, 61
		li a1, 1300
		li a2, 88
		li a3, 110
		li a7, 33
		ecall
								
		j NEXT_FASE
	END_CHECK_ARRIVED_DOOR: ret
	
ATIRA_T1A1:
		la t1, POSICAO_TIRO1_A1
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		
		lb t0, 4(t1)
		bne zero, t0, CONTINUE_CHECK_TIRO_1A1
		la t0, POSICAO_TIRO1_A1
		li a1,64
		li a2, 36
		sh a1, 0(t0)
		sh a2, 2(t0)
		li t3, 1
		sh t3, 4(t0)
		
		j ATIROU_T1A1
		
		CONTINUE_CHECK_TIRO_1A1:
		la t0, ATIRADOR_1_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T1A1
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_1
		lh t2, 0(t0)
		lh t3, 0(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
		addi t3, t3, 8
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T1A1
		la t0, POSICAO_TIRO1_A1
		la t1, ANTIGA_POSICAO_TIRO1_A1
		
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 72
		blt a2,t2, DONT_UPDATE_T2A1
		la t3, POSICAO_TIRO2_A1
		li t4, 1
		sb t4, 4(t3)
		DONT_UPDATE_T2A1:
		li t2, 180
		ble a2, t2 , T1A1_IS_VALID
		
		li a1,64
		li a2, 32
		sh a1, 0(t0)
		sh a2, 2(t0)	
		j ATIROU_T1A1
		T1A1_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a2, a2, 4
		sh a2, 2(t0)
		mv a3,s0
		call PRINT
		
		la t1, ANTIGA_POSICAO_TIRO1_A1
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 1
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T1A1
	END_CHECK_ATIRA_T1A1:
	j ATIROU_T1A1	
ATIRA_T2A1:
		la t1, POSICAO_TIRO2_A1
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		la t0, POSICAO_TIRO2_A1
		lb t1, 4(t0)
		bne zero, t1, CONTINUE_CHECK_TIRO_2A1
		li a1,64
		li a2, 36
		la t0, POSICAO_TIRO2_A1
		sh a1, 0(t0)
		sh a2, 2(t0)
		#li a1,92
		#li a2, 36
		#sh a1, 0(t0)
		#sh a2, 2(t0)
		#li t3, 1
		#sh t3, 4(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T2A1
		
		CONTINUE_CHECK_TIRO_2A1:
		la t0, ATIRADOR_1_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T2A1
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_1
		lh t2, 0(t0)
		lh t3, 0(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
		addi t3, t3, 8
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T2A1
		la t0, POSICAO_TIRO2_A1
		la t1, ANTIGA_POSICAO_TIRO2_A1
		
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 180
		ble a2, t2 , T2A1_IS_VALID
		li a1,64
		li a2, 36
		sh a1, 0(t0)
		sh a2, 2(t0)	
		j ATIROU_T2A1
		T2A1_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a2, a2, 4
		sh a2, 2(t0)
		mv a3,s0
		call PRINT
		la t1, ANTIGA_POSICAO_TIRO2_A1
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 2
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T2A1
	END_CHECK_ATIRA_T2A1:
	j ATIROU_T2A1					

		
ATIRA_T1A2:
		la t1, POSICAO_TIRO1_A2
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		la t0, POSICAO_TIRO1_A2
		lb t1, 4(t0)
		bne zero, t1, CONTINUE_CHECK_TIRO_1A2
		UP_T1_A2:#ebreak
		la t0, POSICAO_TIRO1_A2
		la t4, CAUGHT_KEY_AUX
		lb t5, 0(t4)
		bne zero, t5, T1A2_UPD
		li a1, 32
		li a2, 64
		sh a1, 0(t0)
		sh a2, 2(t0)
		li t3, 1    
		sh t3, 4(t0)
		j ATIROU_T1A2
		T1A2_UPD:
		li a1, 32
		li a2, 212
		sh a1, 0(t0)
		sh a2, 2(t0)
		li t3, 1    
		sh t3, 4(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T1A2
		
		CONTINUE_CHECK_TIRO_1A2:
		la t0, ATIRADOR_2_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T1A2
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_2
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
		addi t3, t3, 8
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T1A2
		la t0, POSICAO_TIRO1_A2
		la t1, ANTIGA_POSICAO_TIRO1_A2
		
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 84
		blt a1,t2, DONT_UPDATE_T2A2
		la t3, POSICAO_TIRO2_A2
		li t4, 1
		sb t4, 4(t3)
		DONT_UPDATE_T2A2:
		li t2, 164
		ble a1, t2,  T1A2_IS_VALID
		j UP_T1_A2
		T1A2_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a1, a1, 4
		sh a1, 0(t0)
		mv a3,s0
		call PRINT
		
		la t1, ANTIGA_POSICAO_TIRO1_A2
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 3
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T1A2
	END_CHECK_ATIRA_T1A2:
	j ATIROU_T1A2
ATIRA_T2A2:
		la t1, POSICAO_TIRO2_A2
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		la t0, POSICAO_TIRO2_A2
		lb t1, 4(t0)
		bne zero, t1, CONTINUE_CHECK_TIRO_2A2
		UP_T2_A2:#ebreak
		la t0, POSICAO_TIRO2_A2
		la t4, CAUGHT_KEY_AUX
		lb t5, 0(t4)
		bne zero, t5, T2A2_UPD
		li a1, 32
		li a2, 64
		sh a1, 0(t0)
		sh a2, 2(t0)
		j ATIROU_T2A2
		T2A2_UPD:
		li a1, 32
		li a2, 212
		sh a1, 0(t0)
		sh a2, 2(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T2A2
		#li a1,92
		#li a2, 36
		#sh a1, 0(t0)
		#sh a2, 2(t0)
		#li t3, 1
		#sh t3, 4(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T2A2
		
		CONTINUE_CHECK_TIRO_2A2:
		la t0, ATIRADOR_2_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T2A2
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_2
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
		addi t3, t3, 8
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T2A2
		la t0, POSICAO_TIRO2_A2
		la t1, ANTIGA_POSICAO_TIRO2_A2
		
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 164
		ble a1, t2 , T2A2_IS_VALID
		j UP_T2_A2
		T2A2_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a1, a1, 4
		sh a1, 0(t0)
		mv a3,s0
		call PRINT
		
		la t1, ANTIGA_POSICAO_TIRO2_A2
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 4
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T2A2
	END_CHECK_ATIRA_T2A2:
	j ATIROU_T2A2		
ATIRA_T1A3:
		la t1, POSICAO_TIRO1_A3
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		la t0, POSICAO_TIRO1_A3
		lb t1, 4(t0)
		bne zero, t1, CONTINUE_CHECK_TIRO_1A3
		UP_T1_A3:
		la t0, POSICAO_TIRO1_A3
		la t4, CAUGHT_KEY_AUX
		lb t5, 0(t4)
		bne zero, t5, T1A3_UPD
		li a1, 88
		li a2, 172
		sh a1, 0(t0)
		sh a2, 2(t0)
		li t3, 1    
		sh t3, 4(t0)
		j ATIROU_T1A3
		T1A3_UPD:
		li a1, 88
		li a2, 102
		sh a1, 0(t0)
		sh a2, 2(t0)
		li t3, 1    
		sh t3, 4(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T1A3
		
		
		CONTINUE_CHECK_TIRO_1A3:
		la t0, ATIRADOR_3_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T1A3
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_3
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
#		addi t3, t3, 8
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T1A3
		la t0, POSICAO_TIRO1_A3
		la t1, ANTIGA_POSICAO_TIRO1_A3
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 76
		bgt a1,t2, DONT_UPDATE_T2A3
	
		la t3, POSICAO_TIRO2_A3
		li t4, 1
		sb t4, 4(t3)
		DONT_UPDATE_T2A3:
		li t2, 46
		bgt a1, t2 , T1A3_IS_VALID
		j UP_T1_A3
		T1A3_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a1, a1, -4
		sh a1, 0(t0)
		mv a3,s0
		call PRINT
		
		la t1, ANTIGA_POSICAO_TIRO1_A3
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 5
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T1A3
	END_CHECK_ATIRA_T1A3:
	j ATIROU_T1A3
ATIRA_T2A3:
		la t1, POSICAO_TIRO2_A3
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		li a3,0
		call PRINT
		li a3,1 
		call PRINT
		la t0, POSICAO_TIRO2_A3
		lb t1, 4(t0)
		bne zero, t1, CONTINUE_CHECK_TIRO_2A3
		UP_T2_A3:
		la t0, POSICAO_TIRO2_A3
		la t4, CAUGHT_KEY_AUX
		lb t5, 0(t4)
		bne zero, t5, T2A3_UPD
		li a1, 88
		li a2, 172
		sh a1, 0(t0)
		sh a2, 2(t0)
		j ATIROU_T2A3
		T2A3_UPD:
		li a1, 88
		li a2, 102
		sh a1, 0(t0)
		sh a2, 2(t0)
		
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		j ATIROU_T2A3
		#li a1,88
		#li a2, 36
		#sh a1, 0(t0)
		#sh a2, 2(t0)
		#li t3, 1
		#sh t3, 4(t0)
		#la t0, ATIRADOR_1_VIVO
		#lb t1, 0(t0)
		#bne zero, t1, 	CONTINUE_CHECK_TIRO_1
		
		
		CONTINUE_CHECK_TIRO_2A3:
		la t0, ATIRADOR_3_VIVO
		lb t1, 0(t0)
		ble t1, zero, END_CHECK_ATIRA_T2A3
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_ATIRADOR_3
		lh t2, 2(t0)
		lh t3, 2(t1)
		addi t3, t3, -2
		slt t5, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t5, t5, t4
#		addi t3, t3, 4
		addi t2, t2, -17
		addi t3, t3, 16
		slt t6, t2,t3
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t4, t6
		or t5, t4, t5
		
		mv a0, t5
		
		beq zero, a0, END_CHECK_ATIRA_T2A3
		la t0, POSICAO_TIRO2_A3
		la t1, ANTIGA_POSICAO_TIRO2_A3
		
		la a0, tiro
		lh a1, 0(t0)
		lh a2, 2(t0)
		li t2, 46
		bgt a1, t2 , T2A3_IS_VALID
		j UP_T2_A3
		T2A3_IS_VALID:
		sh a1, 0(t1)
		sh a2, 2(t1)
		addi a1, a1, -4
		sh a1, 0(t0)
		mv a3,s0
		call PRINT
		
		la t1, ANTIGA_POSICAO_TIRO2_A3
		lh a1, 0(t1)
		lh a2, 2(t1)
		la a0, erase_tiro
		xori a3, a3, 1
		call PRINT
		
		la t0, CURRENT_CHECKED_TIRO
		li t1, 6
		sb t1, 0(t0)
		
		call CHECK_IF_HIT_PERS
				
		j ATIROU_T2A3
	END_CHECK_ATIRA_T2A3:
	j ATIROU_T2A3	

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
	ret

LOST_GAME:
	la a0, sf
	li a2, 60
	li a1, 60
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	li a0, 75
	li a1, 4500
	li a2, 96
	li a3, 120
	li a7, 33
	ecall		
NEXT_FASE:
li a7,104
	la a0, PONTOS_MSG
	li a1,120
	li a2,120
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0, PONTOS_MSG
	li a1,120
	li a2,120
	li a3,0x0038
	li a4,1
	ecall
	
	la t1,PONTOS
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,120
	li a2,140
	li a3,0x0038
	li a4,0
	ecall
	
	la t1, PONTOS
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,120
	li a2,140
	li a3,0x0038
	li a4,1
	ecall
	
li a7, 10
ecall	
.include "SYSTEMv21.s"	
