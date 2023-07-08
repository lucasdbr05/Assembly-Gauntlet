.data 
.include "black.s"
.include "block8.data"
.include "black_block8.data"
#.include "valk.data"
#.include "map1.data"
#.include "cinza.data"
#.include "matriz.data"
#.include "new_chave.data"
#.include "porta_tentativa.data"

PERSO_POS:	.half 8,8
OLD_PERSO_POS:	.half 8,8
flag:		.byte 0 # essa flag � onde vamos guardar a condicao de verdade "faca isso ate que tal coisa aconteca"
DIRECAO:	.byte ' '


.text 

SETUP:		la a0,black 			#o registrador a0 vai receber o endereço do map1
		#la s1,matriz
		addi s1,s1,8
		li a1,0 			#a1 recebe 0
		li a2,0 			#a2 recebe 0
		li a3,0				#a3 recebe 0
		li a4, 320			# largura imagem
		li a5, 239			# altura da imagem
		call PRINT 			#chamamos a LABEL PRINT
		li a3,1 			#a3 recebe 1
		call PRINT 			#chamamos a LABEL PRINT
	
		
		#chamamos a label PRINT duas vezes pois queremos que o mapa apareca tanto se 
		#o frame for 1 quanto se o frame for 0
		
		
CHAVE:
		#la a0,new_chave
		li a1,64
		li a2,216
		li a3,1
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
PORTA:
		#la a0,porta_tentativa
		li a1,24
		li a2,200
		li a3,1
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
		
	
		#desenhando o personagem:ss
GAME_LOOP:	
		call KEY2
		
		xori s0,s0,1 			#vai alternar entre 0 e 1, se o frame atual for 0 ele vai alternar e mostrar o 1	
								
		la t0,PERSO_POS			#t0 guarda a posicao do personagem

		la a0,block_
		lh a1,0(t0)
		lh a2,2(t0) 			#é 2 pq estamos usando uma half word, se fosse word seria 4
		mv a3,s0
		li a4, 8
		li a5, 8
		call PRINT
		
		la t0,OLD_PERSO_POS		#t0 guarda a posicao antiga do personagem
	
		la a0,black_block_test
		lh a1,0(t0)
		lh a2,2(t0) 			#é 2 pq estamos usando uma half word, se fosse word seria 4
		
		mv a3,s0
		xori a3,a3,1
		call PRINT
		
		mv zero,a0
		#la a0,flag 			# vai ler a flag e colocar as informacoes no a0
		li t0,1				# t0 recebe 1
		lb t1, 0(a0)			# t1 recebe as informcoes do a0
		
		beq t1,t0,SAIDA			# se a flag for VERDADEIRA, ou seja, ele chegou na porta e esta com a chave, o c�digo vai fechar
	
		li t0,0xFF200604
		sw s0,0(t0)
		
		j GAME_LOOP
	
KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
	
		li t0,'a' 			#carrega no registrador uma tecla aleatoria que a gente escolhe
		beq t2,t0,PER_ESQ		#faz uma comparacao entre 0 t0 e o t2 (t2 é a tecla que o  usuario clicou)
	
		li t0,'d'
		beq t2,t0,PER_DIR
		
		li t0, 'w'
		beq t2,t0,PER_UP
		
		li t0, 's'
		beq t2,t0,PER_DOWN
		
		li t0, 'l'
		beq t2,t0,ATTACK
		
		
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
			

CHAVE_PEGA:	
		mv s11,zero				# movendo o zero pro s11
		sh t2,0(t1) 				# passando as informa��es do s2 para o t1, que no caso � a antiga pori��o do personagem
		sh t3, 2(t1)				# passando as informa��es do t3 para o proximo endere�o de t1
		sh s4,0(t0)
		li s11,5
				
		ret



	

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


		

		
		

#	
#	a0 = endereco da imagem que queremos imprimir, no caso o MAP1
#	a1 = x - é a linha da imagem
#	a2 = y - é  a coluna da imagem
#	a3 = frame (0 ou 1)
#	a4 = tamanho a pintar (linha)
#	a5 = tamanho a pintar (coluna)
##
#	t0 = endereco do bitmap display
#	t1 = endereco da imagem
#	t2 = contador de linha
#	t3 = contado de coluna

#      s1 = endere�o matriz





PRINT:		li t0, 0xFF0 			#t0 vai recebero emdereço do bitamap
		add t0,t0,a3 			#isso vai definir se o bitmap vai receber bit 1 ou bit 0
		slli t0,t0,20 			#movendo o to 20 bits para a esquerda para dar o tamanho exato do endereço do bitmap
		#endereco do bitmap esta feito
	
		add t0,t0,a1 			#aqui estamos adicionando o x (linha) ao t0(endereco da imagem)
	
		li t1,320 			#adicionando 320 ao t1 para poder multiplicar depois (qtd de pixels em uma linha)
		 	 			#lembrando que em t1 tbm esta o endereço da imagem que queremos imprimir
		mul t1,t1,a2 			#fazendo a multiplicação linha * 320 - desse modo o t1 vai guardar a proxima linha
		add t0,t0,t1 			#adicionando t1 + t0, dessa forma nos vamos adicionar a linha mais a coluna, para saber onde esta 
			     			#localizado o proximo pixel que queremos printar 
	
		addi t1,a0,8 			#aqui nos adicionamos 8 ao a0 pois queremos que ele passe para o proximo endereço, depois movemos td para o t1
	
		mv t2,zero 			#zerando o t2
		mv t3,zero 			#zerando o t3
	
		#lw t4,0(a0) 			#em vez de t4 vamos usar o a4 passado como argumento
		#lw t5,4(a0)			#em vez de t5 vamos usar o a5   "      "       "
	
PRINT_LINHA:
		lw t6,0(t1)
		sw t6,0(t0)
	
		addi t0,t0,4
		addi t1,t1,4
	
		addi t3,t3,4
		blt t3,a4,PRINT_LINHA 		#enquanto t3 for menor que t4 a linha vai ser desenhada
	
		addi t0,t0,320
		sub t0,t0,a4
	
		mv t3,zero
		addi t2,t2,1
		bgt a5,t2,PRINT_LINHA 		#enquanto o contador da linha for menor ou igual a altura, ele vai pular para o PRINT_LINHA
	
		ret
		

	
VERIFICAR:     
	        la, a0,flag			# passando as informa��es da flag para o a0
		li t0,1				# passsando 1 para o t0
		sb t0, 0(a0)			# passando as informa��es do t0 para o a0, ou seja, a flag agora vale 1
		ret				# volta para o game loop
		
CONDICAO_DIREITA:
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		j VERIFICAR
		
CONDICAO_ESQUERDA:	
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		j VERIFICAR
		
CONDICAO_UP:		
		li t5,5 			# guardamos 5 no t5
		bne t5,s11,FIM			# se t5 for diferente de s11 (isso significa que ele n�o tem a chave), voltamos para o in�cio do c�digo (GAME LOOP)
		sh t2,0(t1)			# dessa parte do c�digo at� o verificar s� estamos guardando a posi��o correta do personagem conforme a dire��o que ele v�
		sh t3, 2(t1)			# assim, o c�digo consegue detectar se ele est� tentando entrar na porta por todas as direcoes, pois temos uma condicao para cada
		sh s4,2(t0)
		j VERIFICAR
		
CONDICAO_DOWN:		
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		j VERIFICAR
		
SAIDA:		
		mv a7,zero
		li a7,10
		ecall


FIM:		ret				# retorna
	
