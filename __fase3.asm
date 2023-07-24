.data

FASE_3: .string "FASE 3"

POSICAO_PERSONAGEM: .half 32,8
ANTIGA_POSICAO_PERSONAGEM: .half 164,92
sprite: .word 0x00000000
DIR_PERSONAGEM : .byte 'd'

KEY_POSITION: .half 192, 132
CAUGHT_KEY: .byte 0
CAUGHT_KEY_AUX: .byte 0

POSICAO_TIRO: .half 0,0
ANTIGA_POSICAO_TIRO:.half 0,0




POSICAO_PORTAL: .half 164,92

LIFE_MSG: .string "LIFE: "
LIFE: .byte 5


TIMER: .word 0x0006F4


PONTOS_MSG: .string "SCORE: " 
PONTOS: .word 1000000



#####ATIRADOR ######
POSICAO_ATIRADOR: .half 56,12
POSICAO_TIRO1: .half 92,36,1
ANTIGA_POSICAO_TIRO1: .half 108,36
POSICAO_TIRO2: .half 92,36,0
ANTIGA_POSICAO_TIRO2: .half 108,36
DIR_TIRO: .byte ' '

ATIRANDO_DOWN: .byte 0
ATIRANDO_LEFT: .byte 0
ATIRANDO_RIGHT: .byte 0
LIMIT_DOWN: .half 82
LIMIT_LEFT: .half 180
LIMIT_RIGHT: .half 000
##########




######## FANTASMA #######
POSICAO_FANTASMA :.half 12,32
ANTIGA_POSICAO_FANTASMA: .half 0,0
FANTASMA_VIVO: .byte 10
DIR_FANTASMA: .byte 's'
COUNTER_FANTASMA:.word 0
AUX_T_FANTASMA: .word 0
#########

######## FANTASMA 2 #######
POSICAO_FANTASMA_AUX :.half 60,136
ANTIGA_POSICAO_FANTASMA_AUX: .half 60,160
FANTASMA_AUX_VIVO: .byte 10
DIR_FANTASMA_AUX: .byte 'd'

#########


CURRENT_CHECKED_TIRO:.byte 0
CURRENT_CHECKED_F: .byte 0



#.include "key.data"

.include "lower_block.data"
#.include "block.s"
.include "sprites/fantasma.data"
.include "tiro.data"
.include "black_block.s"
.include "erase_tiro.data"
.include "sprite16x16.data"
.include "mapa_3.data"
.include "matrix3.data"
.include "ghost_gate.data"
.include "../MACROSv21.s"
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

.text
__FASE_3__:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0x07070707	# cor vermelho|vermelho|vermelhor|vermelho
	LOOP_1C: 	
	beq t1,t2,FORA_1C		# Se for o �ltimo endere�o ent�o sai do loop
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	j LOOP_1C	# volta a verificar
	FORA_1C:
	la a0, mapa_3
	li a1, 0
	li a2, 0
	li a3, 0   #FUNDO NO FRAME 0
	call PRINT
	li a3, 1
	call PRINT  #FUNDO NO FRAME 1
	
	la a0, black_block
	li a1, 48
	li a2, 12
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	la a0, black_block
	li a1, 64
	li a2, 12
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT	
	
	la a0, inimigo_baixo
	la t0, POSICAO_ATIRADOR
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	
	
	
	
	li a7,104
	la a0,FASE_3
	li a1,240
	li a2,50
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0,FASE_3
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
	
	
	
	
	j GAME_LOOP
	
GAME_LOOP:

######## TEMPORIZADOR #######
	la t1, TIMER
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
	
	la t1,LIFE
	lb t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,70
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
	
	la t1, PONTOS
	lw t0, 0(t1)
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
	
	la t1, PONTOS
	lw t0, 0(t1)
	li a7,101
	mv a0,t0
	li a1,264
	li a2,90
	li a3,0x0038
	li a4,1
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
	
	
	call MOVER_FANTASMA
	MOVEU_FANTASMA:
	call MOVER_FANTASMA_AUX
	MOVEU_FANTASMA_AUX:
	
	li a1, 'a' 
	call CHECK_TIRO_ATIRADOR
	ATIROU_LEFT:
	li a1, 's' 
	call CHECK_TIRO_ATIRADOR
	ATIROU_DOWN:
	li a1, 'd' 
	call CHECK_TIRO_ATIRADOR
	ATIROU_RIGHT:
	
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
	la t0, CAUGHT_KEY_AUX
	lb t1, 0(t0)
	bne zero, t1, Has_Key
	li t2, 1
	sb t2, 0(t0)
	la t0, KEY_POSITION
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	xori a3, a3,1
	call PRINT
	li t1, 52
	li t2, 180
	la t0, KEY_POSITION
	sh t1, 0(t0)
	sh t2, 2(t0)
	la t0, CAUGHT_KEY
	sb zero, 0(t0)
	la t0, LIMIT_DOWN
	li t1,212
	sh t1, 0(t0)
	
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
	la t6, matrix_test_3
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
	addi t3, t3, 12
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
	la t6, matrix_test_3
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
	addi t3, t3,12
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
	la t6, matrix_test_3
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
	addi t3, t3, 12
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
	la t6, matrix_test_3
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
	addi t3, t3, 12
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
	
	
	end_check_key_md: ret


AUX_GAME_LOOP: j GAME_LOOP
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
			la t6, matrix_test_3
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
		
		call CHECK_IF_KILLED_GHOST
		
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
			la t6, matrix_test_3
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
		
		call CHECK_IF_KILLED_GHOST
		
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
			la t6, matrix_test_3
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
		
		call CHECK_IF_KILLED_GHOST
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
			la t6, matrix_test_3
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
		
		call CHECK_IF_KILLED_GHOST
		
		
		j LOOP_PRINT_TIRO_LEFT
		END_TIRO_LEFT: ret
ret

CHECK_IF_HIT_PERS:
	
						
	
	la a5, POSICAO_TIRO1	
			

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
	la a0, ATIRANDO_DOWN
	sb zero, 0(a0)
	la a0, ATIRANDO_LEFT
	sb zero, 0(a0)
	la a0, ATIRANDO_RIGHT
	sb zero, 0(a0)

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



############ TIRO DO ATIRADOR #########
CHECK_TIRO_ATIRADOR:
	
	li t1, 's'
	beq a1, t1, TIRO_TO_DOWN
	li t1, 'd'
	beq a1, t1, TIRO_TO_RIGHT
	li t1, 'a'
	beq a1, t1, TIRO_TO_LEFT
	
	
	TIRO_TO_DOWN:
	la t2, ATIRANDO_DOWN
	lb t3, 0(t2)
	bne zero, t3, CONTINUE_TIRO_TO_DOWN
	la t2, ATIRANDO_LEFT
	lb t3, 0(t2)
	bne zero, t3, ATIROU_DOWN
	la t2, ATIRANDO_RIGHT
	lb t3, 0(t2)
	bne zero, t3, ATIROU_DOWN
	la t0, POSICAO_TIRO1
	la t1, POSICAO_TIRO2
	li a1, 64
	li a2, 32
	sh a1, 0(t0)
	sh a1, 0(t1)
	sh a2, 2(t0)
	sh a2, 2(t1)
	###
	CONTINUE_TIRO_TO_DOWN:
	li a1, 64
	li a2, 32
	la a0, erase_tiro
	li a3,0
	call PRINT
	li a3,1 
	call PRINT
	la t0, POSICAO_PERSONAGEM
	la t1, POSICAO_ATIRADOR
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
	la t2, ATIRANDO_DOWN
	sb zero, 0(t2)
	
	
	
	bne zero, a0, CONTINUE_ATIROU_DOWN
	j TD_INVALID
	CONTINUE_ATIROU_DOWN: 
	la t2, ATIRANDO_DOWN
	li t1, 1
	sb t1, 0(t2)
	la t0, POSICAO_TIRO1
	la t1, ANTIGA_POSICAO_TIRO1
	
	la a0, tiro
	lh a1, 0(t0)
	lh a2, 2(t0)
	
	la t5, LIMIT_DOWN
	lh t2, 0(t5)
	blt a2, t2 , TD_IS_VALID
	TD_INVALID:
	la t1, POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	la t2, ATIRANDO_DOWN
	sb zero, 0(t2)	
	j ATIROU_DOWN
	TD_IS_VALID:
	sh a1, 0(t1)
	sh a2, 2(t1)
	addi a2, a2, 4
	sh a2, 2(t0)
	mv a3,s0
	
	call PRINT
	la t1, ANTIGA_POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	
	la t0, CURRENT_CHECKED_TIRO
	li t1, 1
	sb t1, 0(t0)
	
	call CHECK_IF_HIT_PERS
	j ATIROU_DOWN

	TIRO_TO_RIGHT:
	la t2, ATIRANDO_RIGHT
	lb t3, 0(t2)
	bne zero, t3, CONTINUE_TIRO_TO_RIGHT
	la t2, ATIRANDO_LEFT
	lb t3, 0(t2)
	bne zero, t3, ATIROU_RIGHT
	la t2, ATIRANDO_DOWN
	lb t3, 0(t2)
	bne zero, t3, ATIROU_RIGHT
	la t0, POSICAO_TIRO1
	la t1, POSICAO_TIRO2
	li a1, 72
	li a2, 24
	sh a1, 0(t0)
	sh a1, 0(t1)
	sh a2, 2(t0)
	sh a2, 2(t1)
	CONTINUE_TIRO_TO_RIGHT:
	li a1, 72
	li a2, 24
	la a0, erase_tiro
	li a3,0
	call PRINT
	li a3,1 
	call PRINT
	la t0, POSICAO_PERSONAGEM
	la t1, POSICAO_ATIRADOR
	
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
	la t0, POSICAO_PERSONAGEM
	la t1, POSICAO_ATIRADOR
	lh t2, 0(t0)
	lh t3, 0(t1)
	slt t3, t3, t2
	mv a1, t3
	and a0, a0, a1
	
	
	la t2, ATIRANDO_RIGHT
	sb zero, 0(t2)
	bne zero, a0, 	CONTINUE_ATIROU_RIGHT
	j TR_INVALID
	CONTINUE_ATIROU_RIGHT:
	la t2, ATIRANDO_RIGHT
	li t1, 1
	sb t1, 0(t2)
	la t0, POSICAO_TIRO1
	la t1, ANTIGA_POSICAO_TIRO1
	
	la a0, tiro
	lh a1, 0(t0)
	lh a2, 2(t0)
	li t2, 200
	ble a1, t2 , TR_IS_VALID
	TR_INVALID:
	la t1, POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	la t2, ATIRANDO_RIGHT
	sb zero, 0(t2)	
	j ATIROU_RIGHT
	la t2, ATIRANDO_RIGHT
	sb zero, 0(t2)	
	j ATIROU_RIGHT
	TR_IS_VALID:
	sh a1, 0(t1)
	sh a2, 2(t1)
	addi a1, a1, 4
	sh a1, 0(t0)
	mv a3,s0
	call PRINT
	
	la t1, ANTIGA_POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	la t0, CURRENT_CHECKED_TIRO
	li t1, 3
	sb t1, 0(t0)
	
	call CHECK_IF_HIT_PERS
			
	j ATIROU_RIGHT

TIRO_TO_LEFT:
	la t2, ATIRANDO_LEFT
	lb t3, 0(t2)
	bne zero, t3, CONTINUE_TIRO_TO_LEFT
	la t2, ATIRANDO_RIGHT
	lb t3, 0(t2)
	bne zero, t3, ATIROU_LEFT
	la t2, ATIRANDO_DOWN
	lb t3, 0(t2)
	bne zero, t3, ATIROU_LEFT
	la t0, POSICAO_TIRO1
	la t1, POSICAO_TIRO2
	li a1, 52
	li a2, 24
	sh a1, 0(t0)
	sh a1, 0(t1)
	sh a2, 2(t0)
	sh a2, 2(t1)
	CONTINUE_TIRO_TO_LEFT:
	li a1, 52
	li a2, 24
	la a0, erase_tiro
	li a3,0
	call PRINT
	li a3,1 
	call PRINT
	la t0, POSICAO_PERSONAGEM
	la t1, POSICAO_ATIRADOR
	
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
	la t0, POSICAO_PERSONAGEM
	la t1, POSICAO_ATIRADOR
	lh t2, 0(t0)
	lh t3, 0(t1)
	slt t3, t2, t3
	mv a1, t3
	and a0, a0, a1
	
	
	la t2, ATIRANDO_LEFT
	sb zero, 0(t2)
	bne zero, a0, 	CONTINUE_ATIROU_LEFT
	j TL_INVALID
	CONTINUE_ATIROU_LEFT:
	la t2, ATIRANDO_LEFT
	li t1, 1
	sb t1, 0(t2)
	la t0, POSICAO_TIRO1
	la t1, ANTIGA_POSICAO_TIRO1
	
	la a0, tiro
	lh a1, 0(t0)
	lh a2, 2(t0)
	li t2, 10
	bge a1, t2 , TL_IS_VALID
	TL_INVALID:
	la t1, POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	la t2, ATIRANDO_LEFT
	sb zero, 0(t2)	
	j ATIROU_LEFT
	la t2, ATIRANDO_LEFT
	sb zero, 0(t2)	
	j ATIROU_LEFT
	TL_IS_VALID:
	sh a1, 0(t1)
	sh a2, 2(t1)
	addi a1, a1, -4
	sh a1, 0(t0)
	mv a3,s0
	call PRINT
	
	la t1, ANTIGA_POSICAO_TIRO1
	lh a1, 0(t1)
	lh a2, 2(t1)
	la a0, erase_tiro
	li a3, 1
	call PRINT
	li a3, 0
	call PRINT
	la t0, CURRENT_CHECKED_TIRO
	li t1, 3
	sb t1, 0(t0)
	
	call CHECK_IF_HIT_PERS
			
	j ATIROU_LEFT
	
#################################################################################
	CHECK_IF_HIT_GHOST:
		la t0, CURRENT_CHECKED_F
		lb t1, 0(t0)
		beq t1, zero, IS_FN
		li t0, 1
		beq t1,t0,IS_FAUX
		IS_FN:
		la a3, POSICAO_FANTASMA
		la a4, FANTASMA_VIVO
		j CONTINUE_CHECK_IF_HIT_GHOST
		IS_FAUX:
		la a3, POSICAO_FANTASMA_AUX
		la a4, FANTASMA_AUX_VIVO
		j CONTINUE_CHECK_IF_HIT_GHOST	
		
		
		
		CONTINUE_CHECK_IF_HIT_GHOST:
		
		la t0, POSICAO_PERSONAGEM
		
		mv t1, a3
		
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
		addi t3, t3, 16
		addi t2, t2, 17
		slt t4, t3, t2
		and t4, t6, t4
		or t5, t5, t4
		
		mv a0, t5
		
		and a0, a0, a1
		
		
		beq zero, a0, END_CHECK_HIT_GHOST
		
		la t1, LIFE
		lb t0, 0(t1)
		addi t0, t0, -1
		sb t0, 0(t1)
		beq t0, zero, LOST_GAME
		mv t0, a3
		la a0, black_block
		lh a1, 0(t0)
		lh a2, 2(t0)
		mv a3,s0
		
		call PRINT
		mv t0,a4
		sb zero, 0(t0)
		la t0,AUX_T_FANTASMA
		sb zero, 0(t0)
		j MOVEU_FANTASMA						
		
	END_CHECK_HIT_GHOST: ret
#######################################################
CHECK_IF_KILLED_GHOST:
		la t0, CURRENT_CHECKED_F
		lb t1, 0(t0)
		beq t1, zero, KG_FN
		li t0, 1
		beq t1,t0,KG_FAUX
		KG_FN:
		la a4, POSICAO_FANTASMA
		la a5, FANTASMA_VIVO
		j CONTINUE_CHECK_IF_KILLED_GHOST
		KG_FAUX:
		la a4, POSICAO_FANTASMA_AUX
		la a5, FANTASMA_AUX_VIVO
		j CONTINUE_CHECK_IF_KILLED_GHOST	
		
	
		mv t0, a5
		lb t1, 0(t0)
		bne zero, t1, 	CONTINUE_CHECK_IF_KILLED_GHOST
		ret
	
		CONTINUE_CHECK_IF_KILLED_GHOST:
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
		beq zero, a0, END_CHECK_KGHOST
		mv t1, a5
		#mv t0, a4
		#la a0, black_block
		#lh a1, 0(t0)
		#lh a2, 2(t0)
		#mv a3,s0

		#call PRINT
		
		lb t0, 0(t1)
		addi t0, t0, -1
		sb t0, 0(t1)						
		j GAME_LOOP
	END_CHECK_KGHOST: ret
##### FANTASMA
MOVER_FANTASMA:
	la t0, FANTASMA_VIVO
	lb t1,0(t0)
	bne t1, zero, CONTINUE_MOVER_FANTASMA
	la t0, POSICAO_FANTASMA
	li t1,12
	sh t1, 0(t0)
	li t1,32
	sh t1, 2(t0)
	la t0, FANTASMA_VIVO
	li t3, 1
	sb t3, 0(t0)
	#la t0, COUNTER_FANTASMA
	#lw t1, 0(t0)
	#addi t1, t1, 1
	#sw t1, 0(t0)
	#li t2, 0x100
	#rem t2,t1, t2
	#bne t2, zero,END_MOVER_FANTASMA
	#ebreak
	#sw zero, 0(t0)
	j MOVEU_FANTASMA
	CONTINUE_MOVER_FANTASMA:
	
	la t0, POSICAO_FANTASMA
	la t3, ANTIGA_POSICAO_FANTASMA
	lh t1, 0(t0)
	lh t2, 2(t0)
	sh t1, 0(t3)
	sh t2, 2(t3)
	
	####
	
	
	
	MOVER_FANTASMA_LOOP:
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	la t1, AUX_T_FANTASMA
	lb t0, 0(t1)
	li t2, 4
	rem t1, t0, t2
	
	beq zero, t1,MOVER_FANTASMA_BAIXO
	li t2, 1
	beq t2,t1, MOVER_FANTASMA_DIREITA
	li t2, 2
	beq t2, t1, MOVER_FANTASMA_ESQUERDA
	li  t2, 3 
	beq t2, t1,  MOVER_FANTASMA_CIMA
	
	MOVER_FANTASMA_ESQUERDA:
	
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	addi t1, t1, -4
	sh t1, 0(t0)
	li t2, 12
	ble t1, t2, ADD_AUX_T_FANTASMA
	j CONTINUA_FANTASMA
	MOVER_FANTASMA_DIREITA:
	
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	addi t1, t1, 4
	sh t1, 0(t0)
	li t2, 180
	bgt t1, t2, ADD_AUX_T_FANTASMA
	j CONTINUA_FANTASMA
	MOVER_FANTASMA_BAIXO:
	
	la t0, POSICAO_FANTASMA
	lh t1, 2(t0)
	addi t1, t1, 4
	sh t1, 2(t0)
	li t2, 204
	bgt t1, t2, ADD_AUX_T_FANTASMA
	j CONTINUA_FANTASMA
	MOVER_FANTASMA_CIMA:
	la t0, POSICAO_FANTASMA
	lh t1, 2(t0)
	addi t1, t1, -4
	sh t1, 2(t0)
	li t2, 32
	ble t1, t2, ADD_AUX_T_FANTASMA
	j CONTINUA_FANTASMA
	ADD_AUX_T_FANTASMA:
	la t5, AUX_T_FANTASMA
	lw t1, 0(t5)
	addi t1, t1, 1
	sw t1, 0(t5)
	j CONTINUA_FANTASMA
	CONTINUA_FANTASMA:
	la t0, POSICAO_FANTASMA
	la a0, block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3,s0
	
	call PRINT
	
	

	la t0, ANTIGA_POSICAO_FANTASMA
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3,s0
	xori a3, a3, 1
	
	
	call PRINT
	
	la t0, CURRENT_CHECKED_F
	sb zero, 0(t0)
	call CHECK_IF_HIT_GHOST
	
	
	

	END_MOVER_FANTASMA:
		j MOVEU_FANTASMA
######################################

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
		
								
		j NEXT_FASE
	END_CHECK_ARRIVED_DOOR: ret
MOVER_FANTASMA_AUX:
	la t0, FANTASMA_AUX_VIVO
	lb t1,0(t0)
	bne t1, zero, CONTINUE_MOVER_FANTASMA_AUX
	la t0, POSICAO_FANTASMA_AUX
	li t1,60
	sh t1, 0(t0)
	li t1,136
	sh t1, 2(t0)
	la t0, FANTASMA_AUX_VIVO
	li t3, 1
	sb t3, 0(t0)
	
	j MOVEU_FANTASMA_AUX
	CONTINUE_MOVER_FANTASMA_AUX:
	
	la t0, POSICAO_FANTASMA_AUX
	la t3, ANTIGA_POSICAO_FANTASMA_AUX
	lh t1, 0(t0)
	lh t2, 2(t0)
	sh t1, 0(t3)
	sh t2, 2(t3)
	
	####
	
	la t0, POSICAO_FANTASMA_AUX
	lh t1, 0(t0)
	li t2,50
	blt t1, t2, DIR_AUX_DIREITA
	li t2, 144
	bgt t1, t2, DIR_AUX_ESQUERDA
	la t1, DIR_FANTASMA_AUX
	lb t0, 0(t1)
	li t2, 'd'
	beq t2, t0, MOVER_FANTASMA_AUX_DIREITA
	li t2, 'a'
	beq t2, t0, MOVER_FANTASMA_AUX_ESQUERDA
	
	DIR_AUX_DIREITA:
	la t4, DIR_FANTASMA_AUX
	li t5, 'd'
	sb t5, 0(t4)
	MOVER_FANTASMA_AUX_DIREITA:
	la t0, POSICAO_FANTASMA_AUX
	lh t1, 0(t0)
	addi t1, t1, 4
	sh t1, 0(t0)
	j CONTINUA_FANTASMA_AUX
	DIR_AUX_ESQUERDA:
	la t4, DIR_FANTASMA_AUX
	li t5, 'a'
	sb t5, 0(t4)
	MOVER_FANTASMA_AUX_ESQUERDA:
	la t0, POSICAO_FANTASMA_AUX
	lh t1, 0(t0)
	addi t1, t1, -4
	sh t1, 0(t0)
	j CONTINUA_FANTASMA_AUX
	
	CONTINUA_FANTASMA_AUX:
	la t0, POSICAO_FANTASMA_AUX
	la a0, block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3,s0
	
	call PRINT
	
	

	la t0, ANTIGA_POSICAO_FANTASMA_AUX
	la a0, black_block
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3,s0
	xori a3, a3, 1
	
	
	call PRINT
	
	la t0, CURRENT_CHECKED_F
	li t1, 1
	sb t1, 0(t0)
	call CHECK_IF_HIT_GHOST
	
	
	

	END_MOVER_FANTASMA_AUX:
		j MOVEU_FANTASMA_AUX


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
	
	li a0,2000 
	li a7,132
	ecall
	
	j __FASE_3__			
NEXT_FASE:
li a7, 10
ecall	
.include "../SYSTEMv21.s"	
