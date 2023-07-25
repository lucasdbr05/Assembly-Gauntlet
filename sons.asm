SOM_TIRO:		#label para o som de tiro
	li a0, 22	#muda a nota
	li a1, 450	#muda a duração (está em milissegundos)
	li a2, 15	#muda o instrumento
	li a3, 112	#muda o  volume
	li a7, 33
	ecall
	ret

SOM_DANO_TIRO:		#qnd o personagem leva dano de tiro
	li a0, 60
	li a1, 350
	li a2, 112
	li a3, 100
	li a7, 33
	ecall
	ret

SOM_HIT_FANTASMA:	#qnd o personagem leva hit do fantasma
	li a0, 73
	li a1, 350
	li a2, 112
	li a3, 115
	li a7, 33
	ecall
	ret

SOM_PAREDE:		#qnd o personagem bate na parede
	li a0, 8	
	li a1, 350	
	li a2, 96	
	li a3, 127	
	li a7, 33	
	ecall
	ret

SOM_CHAVE:		#qnd o personagem pega a chave
	li a0, 61
	li a1, 1300
	li a2, 88
	li a3, 110
	li a7, 33
	ecall
	ret

SOM_FASE:		#qnd passar de fase
	li a0, 96	
	li a1, 4500	
	li a2, 46	
	li a3, 127	
	li a7, 33	
	ecall
	ret

SOM_INICIO_JOGO:	#qnd o jogo começa
	li a0, 75
	li a1, 4500
	li a2, 96
	li a3, 120
	li a7, 33
	ecall
	ret