.data
	msg_row1:  		.asciiz "Linhas da matriz 1: "
 	msg_col1:  		.asciiz "Colunas da matriz 1: "
 	msg_row2:  		.asciiz "Linhas da matriz 2: "
 	msg_col2:  		.asciiz "Colunas da matriz 2: "
 	msg_retry:		.asciiz "Colunas de 1 deve ser = a Linhas de 2..."

.text
	main:
		retry:
			la $a0, msg_row1		
  			li $v0, 4				# printf("Linhas da matriz 1: ");
  			syscall
  			li $v0, 5  				# scanf("%d", &row1);
  			syscall
  			move $s0, $v0
  		
  			la $a0, msg_col1		
  			li $v0, 4				# printf("Colunas da matriz 1: ");
  			syscall
  			li $v0, 5  				# scanf("%d", &col1);
  			syscall
  			move $s1, $v0
  		
  			la $a0, msg_row2		
  			li $v0, 4				# printf("Linhas da matriz 2: ");
  			syscall
  			li $v0, 5  				# scanf("%d", &row2);
  			syscall
  			move $s2, $v0
  		
  			la $a0, msg_col2		
  			li $v0, 4				# printf("Colunas da matriz 2: ");
  			syscall
  			li $v0, 5  				# scanf("%d", &col2);
  			syscall
  			move $s3, $v0
  		bne $s1, $s2, retry
  		
  		li $v0, 11
  		li $a0, 10 					# printf("\n");
  		syscall
  		
  		mul $t0, $s0, $s1
  		sll $t0, $t0, 2
  		sub $sp, $sp, $t0					# int matriz1[row1][col1]
  		move $s4, $sp
  		
  		mul $t0, $s2, $s3
  		sll $t0, $t0, 2
  		sub $sp, $sp, $t0					# int matriz2[row2][col2]
  		move $s5, $sp
  		
  		mul $t0, $s0, $s3
  		sll $t0, $t0, 2
  		sub $sp, $sp, $t0					# int matriz3[row1][col2]
  		move $s6, $sp
  		
  		
  		li $t2, 1						# cont = 1
  		li $t0, 0						# i=0
  		for_i:
  			beq $t0, $s0, end_for_i				# i<row1
  			
  			li $t1, 0					# j=0
  			for_j:
  				beq $t1, $s1, end_for_j			#j <col1
  				
  				mul $t3, $t0, $s1
  				add $t3, $t3, $t1			# i*col1 + j
  				sll $t3, $t3, 2
  				add $t3, $t3, $s4
  				
  				sw $t2, 0($t3) 				# matriz1[i][j] = cont
  				
  				li $v0, 1
  				move $a0, $t2 				# printf(" %d ", cont);
  				syscall
  				
  				li $v0, 11
  				li $a0, 32 			# printf(" ");
  				syscall
  				
  				addi $t2, $t2, 1
  				addi $t1, $t1, 1
  				j for_j
  			end_for_j:
  			
  			li $v0, 11
  			li $a0, 10 				# printf("\n");
  			syscall
  			
  			addi $t0, $t0, 1
  			j for_i
  		end_for_i:
  		
  		
  		li $v0, 11
  		li $a0, 10 					# printf("\n");
  		syscall
  		
  		
  		li $t2, 1						# cont = 1
  		li $t0, 0						# i=0
  		for_i2:
  			beq $t0, $s2, end_for_i2			# i<row1
  			
  			li $t1, 0					# j=0
  			for_j2:
  				beq $t1, $s3, end_for_j2		#j <col1
  				
  				mul $t3, $t0, $s3
  				add $t3, $t3, $t1			# i*col2 + j
  				sll $t3, $t3, 2
  				add $t3, $t3, $s5
  				
  				sw $t2, 0($t3) 				# matriz2[i][j] = cont
  				
  				li $v0, 1
  				move $a0, $t2 			# printf(" %d ", cont);
  				syscall
  				
  				li $v0, 11
  				li $a0, 32 			# printf(" ");
  				syscall
  				
  				addi $t2, $t2, 1
  				addi $t1, $t1, 1
  				j for_j2
  			end_for_j2:
  			
  			li $v0, 11
  			li $a0, 10 				# printf("\n");
  			syscall
  			
  			addi $t0, $t0, 1
  			j for_i2
  		end_for_i2:
  		
  		
  		li $v0, 11
  		li $a0, 10 					# printf("\n");
  		syscall
  		
  		
  		li $t0, 0						# i=0
  		for_i3:
  			beq $t0, $s0, end_for_i3			# i<row1
  			
  			li $t1, 0					# j=0
  			for_j3:
  				beq $t1, $s3, end_for_j3		#j<col2
  				
  				li $t5, 0				#aux = 0
  				li $t2, 0				# k=0
  				for_k:
  					beq $t2, $s1, end_for_k 	# k<col1
  					
  					mul $t3, $t0, $s1
  					add $t3, $t3, $t2
  					sll $t3, $t3, 2
  					add $t3, $t3, $s4		# matriz1[i][k]
  					lw $t3, 0($t3)
  					
  					mul $t4, $t2, $s3
  					add $t4, $t4, $t1
  					sll $t4, $t4, 2
  					add $t4, $t4, $s5		# matriz2[k][j]
  					lw $t4, 0($t4)
  					
  					mul $t3, $t3, $t4
  					add $t5, $t5, $t3     		# aux += matriz1[i][k] * matriz2[k][j];
  					
  					addi $t2, $t2, 1
  					j for_k
  				end_for_k:
  				
  				mul $t3, $t0, $s3
  				add $t3, $t3, $t1
  				sll $t3, $t3, 2
  				add $t3, $t3, $s6			# matriz3[i][j] = aux;
  				sw $t5, 0($t3)
  				
  				li $v0, 1
  				move $a0, $t5 			# printf(" %d ", matriz3[i][j]);
  				syscall
  				
  				li $v0, 11
  				li $a0, 32 			# printf(" ");
  				syscall
  				
  				addi $t1, $t1, 1
  				j for_j3
  			end_for_j3:
  			
  			li $v0, 11
  			li $a0, 10 				# printf("\n");
  			syscall
  			  			
  			addi $t0, $t0, 1
  			j for_i3
  		end_for_i3:
