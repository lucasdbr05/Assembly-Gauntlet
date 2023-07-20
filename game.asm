.data
FASE_1: .string "FASE 1"


POSICAO_PERSONAGEM: .half 160,80
ANTIGA_POSICAO_PERSONAGEM: .half 160,80

KEY_POSITION: .half 180, 200
CAUGHT_KEY: .byte 0

POSICAO_TIRO: .half 0,0
ANTIGA_POSICAO_TIRO:.half 0,0
DIR_PERSONAGEM : .byte ' '


LIFE_MSG: .string "LIFE: "
LIFE: .byte 5

PONTOS_MSG: .string "SCORE: " 
PONTOS: .word 1000000


#####FANTASMA 1######
POSICAO_FANTASMA: .half 140,180
ANTIGA_POSICAO_FANTASMA: .half 112,180
FANTASMA_VIVO: .byte 1
DIR_FANTASMA: .byte 'd'
COUNTER_FANTASMA:.word 0X00000000
##########



TEST: .word 0x0000FFFF


.include "key.data"
#.include "matrix_test.data"
.include "test_mapa.data"
.include "lower_block.data"
.include "block.s"
.include "black.s"
.include "tiro.data"
.include "black_block.s"
.include "erase_tiro.data"
.include "../MACROSv21.s"
.include "mapa_inicial.data"
.include "under_mapa.data"
.include "sprite16x16.data"
.include "mapa_3.data"
.include "matrix3.data"


.text

MAPA:  
	la a0, mapa_1
	li a1, 0
	li a2, 0
	li a3, 0   #FUNDO NO FRAME 0
	call PRINT
	li a3, 1
	call PRINT  #FUNDO NO FRAME 1
	
	
	li a7,104
	la a0,FASE_1
	li a1,240
	li a2,50
	li a3,0x0038
	li a4,0
	ecall
	
	li a7,104
	la a0,FASE_1
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
	
GAME_LOOP:
	call INPUT #PROCEDIMENTO QUE CHECA SE HÁ ALGUM BOTÃO QUE FOI APERTADO
	 #s0: frame a ser escolhido
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
	 
	 
	xori s0, s0, 1  #modifica os frames ente 0 e 1
	
	la t0, POSICAO_PERSONAGEM  
	la a0, sprite16x16  #imagem a ser carregada
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
	
	j MOVER_FANTASMA
	MOVEU_FANTASMA:
	
	
	la t1, CAUGHT_KEY
	lb t0, 0(t1)
	bne zero,t0, Has_KEY
	la t0, KEY_POSITION
	la a0, key
	lh a1, 0(t0)
	lh a2, 2(t0)
	mv a3, s0
	
	
	xori a3, a3,1
	call PRINT
	j GAME_LOOP
	Has_KEY:
	la t0, KEY_POSITION
	la a0, erase_tiro
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
	la t6, matrix_test
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
	la t6, matrix_test
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
	la t6, matrix_test
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
	la t6, matrix_test
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

ATTACK:
	#Atualiza posicao inicial do tiro
	#la t0, POSICAO_PERSONAGEM
	#lh t1, 0(t0)
	#lh t2, 2(t0)
	#la t0, POSICAO_TIRO
	#sh t1, 0(t0)
	#sh t2, 2(t0)
	
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
			la t6, matrix_test
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
		
		call PRINT_TIRO
		
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
		
		#ebreak
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
			la t6, matrix_test
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
		
		call PRINT_TIRO
		
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
			la t6, matrix_test
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
		
		call PRINT_TIRO
		
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
		
		#ebreak
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
			la t6, matrix_test
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
		
		call PRINT_TIRO
		
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
		
		#ebreak
		call CHECK_IF_KILLED_GHOST
		
		
		
		j LOOP_PRINT_TIRO_LEFT
		END_TIRO_LEFT: ret

		
				
	CHECK_IF_KILLED_GHOST:
		la t0, FANTASMA_VIVO
		lb t1, 0(t0)
		bne zero, t1, 	CONTINUE_CHECK_IF_KILLED_GHOST
		ret
	
		CONTINUE_CHECK_IF_KILLED_GHOST:
		la t0, POSICAO_FANTASMA
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
		beq zero, a0, END_CHECK_GHOST
		la t0, POSICAO_FANTASMA
		la a0, black_block
		lh a1, 0(t0)
		lh a2, 2(t0)
		mv a3,s0
		
		call PRINT
		la t0, FANTASMA_VIVO
		sb zero, 0(t0)						
		j GAME_LOOP
	END_CHECK_GHOST: ret


	CHECK_IF_HIT_GHOST:
		la t0, FANTASMA_VIVO
		lb t1, 0(t0)
		bne zero, t1, 	CONTINUE_CHECK_IF_HIT_GHOST
		ret
		
		CONTINUE_CHECK_IF_HIT_GHOST:
		
		la t0, POSICAO_PERSONAGEM
		la t1, POSICAO_FANTASMA
		
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
		
		la t0, POSICAO_FANTASMA
		la a0, black_block
		lh a1, 0(t0)
		lh a2, 2(t0)
		mv a3,s0
		
		call PRINT
		la t0, FANTASMA_VIVO
		sb zero, 0(t0)						
		j GAME_LOOP
	END_CHECK_HIT_GHOST: ret



MOVER_FANTASMA:
	la t0, FANTASMA_VIVO
	lb t1,0(t0)
	beq t1, zero, END_MOVER_FANTASMA
	#la t0, COUNTER_FANTASMA
	#lw t1, 0(t0)
	#addi t1, t1, 1
	#sw t1, 0(t0)
	#li t2, 0x100
	#rem t2,t1, t2
	#bne t2, zero,END_MOVER_FANTASMA
	#ebreak
	#sw zero, 0(t0)
	#ebreak
	
	
	
	la t0, POSICAO_FANTASMA
	la t3, ANTIGA_POSICAO_FANTASMA
	lh t1, 0(t0)
	lh t2, 2(t0)
	sh t1, 0(t3)
	sh t2, 2(t3)
	
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	li t2, 192
	
	bgt t1, t2, DIR_FANTASMA_ESQUERDA
	li t2, 100
	blt t1,t2, DIR_FANTASMA_DIREITA
	li t1, 'd'
	la t3, DIR_FANTASMA
	lb t2, 0(t3)
	beq t1, t2, MOVER_FANTASMA_DIREITA
	DIR_FANTASMA_ESQUERDA:
	la t4, DIR_FANTASMA
	li t5, 'a'
	sb t5, 0(t4)
	MOVER_FANTASMA_ESQUERDA:
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	addi t1, t1, -4
	sh t1, 0(t0)
	j CONTINUA_FANTASMA
	DIR_FANTASMA_DIREITA:
	la t4, DIR_FANTASMA
	li t5, 'd'
	sb t5, 0(t4)
	MOVER_FANTASMA_DIREITA:
	la t0, POSICAO_FANTASMA
	lh t1, 0(t0)
	addi t1, t1, 4
	sh t1, 0(t0)
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

	call CHECK_IF_HIT_GHOST
	


END_MOVER_FANTASMA:j MOVEU_FANTASMA















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
	
	addi  t3, t3, 4
	blt t3, t4, PRINT_TIRO.Line
	
	addi t0, t0, 320
	sub t0, t0,t4
	
	mv t3, zero
	addi t2, t2, 1
	
	blt t2, t5, PRINT_TIRO.Line
	ret

	
		
.include "../SYSTEMv21.s"	
