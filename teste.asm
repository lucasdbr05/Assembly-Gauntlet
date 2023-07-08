

#####NA PARTE DE MOVIMENTACAO DE PERSONAGEM (BASICAMENTE SALVEI UM JEITO DE GUARDAR A DIREÇÃO QUE ELE ESTÁ INDO)

	

PER_ESQ:		la t0, DIRECAO
		li t1, 'a'
		sb t1, 0(t0)
		
		la t0,PERSO_POS				#o personagem mover a esquerda é igual a diminuir o valor de x
		la t1,OLD_PERSO_POS			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)

		
		lh s4,0(t0)
		addi s4,s4,-8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_ESQUERDA	
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)

		ret
		
PER_DIR:	     la t0, DIRECAO
		li t1, 'd'
		sb t1, 0(t0)

		la t0,PERSO_POS				#o personagem mover a esquerda é igual a diminuir o valor de x
		la t1,OLD_PERSO_POS			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)

		
		lh s4,0(t0)
		addi s4,s4,8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		#verificar se o valor na posicao � igual ao valor que representa a chave na matriz
		#se for a booleana de pegar a chave recebe 1
		#quando a booleana da chave estiver em 1 eu n�o printo ela 
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DIREITA
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		
		ret
		
PER_UP:		la t0, DIRECAO
		li t1, 'w'
		sb t1, 0(t0)
		la t0, PERSO_POS
		la t1, OLD_PERSO_POS
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		
		lh s4,2(t0)
		addi s4,s4,-8
		li t5,320
		mul t5,s4,t5
		add s2,s1,t5
		add s2,s2,t2
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_UP
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		
		
		ret
		
PER_DOWN:	la t0, DIRECAO
		li t1, 's'
		sb t1, 0(t0)
		la t0, PERSO_POS
		la t1, OLD_PERSO_POS
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		lh s4,2(t0)
		addi s4,s4,8
		li t5,320
		mul t5,s4,t5
		add s2,s1,t5
		add s2,s2,t2
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DOWN
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		
		
		ret


		

















#####Substituir ataque
ATTACK:		la t0,DIRECAO 				# guarda a direcao para onde o personagem esta querendo ir
		lb t5, 0(t0)				# passa as informacoes do t0 para o t5
		li t1, 'w'
		beq t5, t1, ATT_UP			# se ele quiser ir para dima, o ataque tambem vai para cima
		li t1, 's'
		beq t5, t1, ATT_DOWN			# se ele quiser ir para baixo o ataque tambem vai para baixo
		li t1,'d'
		beq t5, t1, ATT_DIREITA			# se ele quiser ir para a direita o ataque tambem vai para a esquerda
		li t1, 'a'
		beq t5, t1, ATT_ESQUERDA		# se ele quiser ir para a esquerda o ataque tambem ira para a direita
		ret
		
ATT_UP:		la t0,PERSO_POS				# carregando a posicao do personagem na matriz
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		
		LOOP_ATT_UP:
		ble a3, zero, END_LOOP_ATT_UP 		# quando ele chega no final da tela ele para
		addi a3, a3, -8 			# aqui ele vai somar pra verificar se nao passou do tamanho do mapa, usamos 8 pois nosso personagem tem o tam de um byte
		j LOOP_ATT_UP 				# ele vai carregar toda a linha, quando toda a linha estiver carregada ele vai "atirar por cima dessa linha"
		
		END_LOOP_ATT_UP:			# os passos a seguir estao apenas definindo os dados que sao requeridos pelo ecall 47 (syscall de printar linha)
		li a4, 0x38 				# cor
		mv a5, s0 				# frame que ele ta imprimindo
		li a7, 47 				# chama a ecaal de desenhar linha (o tiro eh uma linha)
		ecall	
		
		li t0, 10000
		
		LOOP_ERASE_LASER_UP:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_UP
		la t0,PERSO_POS
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		
		LOOP_ERASE_UP:
		ble a3, zero, END_LOOP_ERASE_UP
		addi a3, a3, -8
		j LOOP_ERASE_UP
		
		END_LOOP_ERASE_UP:
		li a4, 0x000
		mv a5, s0
		li a7, 47
		ecall
		ret
			      				
ATT_DOWN:	la t0,PERSO_POS	 		# carregando a posicao do personagem na matriz
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		mv a3, a1
		li t0, 240
		
		LOOP_ATT_DOWN:
		bge a3, t0, END_LOOP_ATT_DOWN 		# quando ele chega no final da tela ele para
		addi a3, a3, 8 				# aqui ele vai somar pra verificar se nao passou do tamanho do mapa, usamos 8 pois nosso personagem tem o tam de um byte
		j LOOP_ATT_DOWN 			# ele vai carregar toda a linha, quando toda a linha estiver carregada ele vai "atirar por cima dessa linha"
		
		END_LOOP_ATT_DOWN:			# os passos a seguir estao apenas definindo os dados que sao requeridos pelo ecall 47 (syscall de printar linha)
		li a4, 0x38				# cor
		mv a5, s0 				# frame que ele ta imprimindo
		li a7, 47 				# chama a ecaal de desenhar linha (o tiro eh uma linha)
		ecall
		li t0, 10000  		
		
		LOOP_ERASE_LASER_DOWN:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_DOWN
		li a4, 0x000
		li a7,47
		ecall
		ret		

ATT_DIREITA:	la t0,PERSO_POS	 		# carregando a posicao do personagem na matriz
		lh a0, 0(t0)
		lh a1, 2(t0)
		li t0, 320 				# agora nao estamos usando mais a coluna e sim a linha, pois queremos que o tiro se mova na horizontal
		mv a2, a0
		
		LOOP_ATT_DIREITA:
		bge a2, t0, END_LOOP_ATT_DIREITA 	# quando ele chega no final da tela ele para
		addi a2, a2, 8 				# aqui ele vai somar pra verificar se nao passou do tamanho do mapa, usamos 8 pois nosso personagem tem o tam de um byte
		j LOOP_ATT_UP 				# ele vai carregar toda a linha, quando toda a linha estiver carregada ele vai "atirar por cima dessa linha"
		
		END_LOOP_ATT_DIREITA:
		mv a3, a1			# os passos a seguir estao apenas definindo os dados que sao requeridos pelo ecall 47 (syscall de printar linha)
		li a4, 0x38 				# cor
		mv a5, s0 				# frame que ele ta imprimindo
		li a7, 47 				# chama a ecaal de desenhar linha (o tiro eh uma linha)
		ecall
		li t0, 10000  				
		
		LOOP_ERASE_LASER_DIREITA:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_DIREITA
		li a4, 0x000
		li a7,47
		ecall
		ret		

ATT_ESQUERDA:	la t0,PERSO_POS	 		# carregando a posicao do personagem na matriz
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		
		LOOP_ATT_ESQUERDA:
		ble a2, zero, END_LOOP_ATT_ESQUERDA 	# quando ele chega no final da tela ele para
		addi a2, a2, -8 			# aqui ele vai somar pra verificar se nao passou do tamanho do mapa, usamos 8 pois nosso personagem tem o tam de um byte
		j LOOP_ATT_ESQUERDA 			# ele vai carregar toda a linha, quando toda a linha estiver carregada ele vai "atirar por cima dessa linha"
		
		END_LOOP_ATT_ESQUERDA:
		mv a3,a1			# os passos a seguir estao apenas definindo os dados que sao requeridos pelo ecall 47 (syscall de printar linha)
		li a4, 0x38 				# cor
		mv a5, s0 				# frame que ele ta imprimindo
		li a7, 47 				# chama a ecaal de desenhar linha (o tiro eh uma linha)
		ecall
		li t0, 10000  				
		
		LOOP_ERASE_LASER_ESQUERDA:
		addi t0, t0, -1
		bge t0, zero, LOOP_ERASE_LASER_ESQUERDA
		la t0,PERSO_POS
		lh a0, 0(t0)
		lh a1, 2(t0)
		mv a2, a0
		
		LOOP_ERASE_LEFT:
		ble a2, zero, END_LOOP_ERASE_LEFT
		addi a2, a2, -8
		j LOOP_ERASE_LEFT
		
		END_LOOP_ERASE_LEFT:
		mv a3,  a1
		li a4, 0x000
		mv a5, s0
		li a7, 47
		ecall
		ret	
			