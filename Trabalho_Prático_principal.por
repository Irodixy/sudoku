programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Tipos --> ti
	inclua biblioteca Teclado --> te
	inclua biblioteca Util --> u
	inclua biblioteca Mouse --> m

	const inteiro x_un_table=60, y_un_table=60
	inteiro largura_tela=1000, altura_tela=900
	inteiro x_inc_tabela=50, y_inc_tabela=50
	logico arredondar_cantos=falso, preencher=falso, manter_visivel=verdadeiro

	logico clicou_direito = falso, clicou_esquerdo = falso

	/* Variáveis usadas para detectar o clique do mouse */
	inteiro ultimo_x = -1, ultimo_y = -1

	inteiro imagem_fundo = 0

	inteiro botao_escolhido = 0
	logico por_cima_voltar = falso
	logico por_cima_validar = falso
	logico voltar_menu_principal = falso

	logico parabens = falso
	
	// Valores da posição e cliques do rato face à matriz Sudoku
	inteiro Xclicado = -1, Yclicado = -1
	inteiro Xhover = -1, Yhover = -1

	//Valores da posição e cliques do rato face aos restantes botões
	inteiro cursor_hover = -1
	inteiro cursor_clicou = -1

	// Guarda qual caixa tem o cursor em cima: 1 - Fácil, 2 - Médio, 3 - Difícil
	logico caixa_nivel[3]
	
	//define 1 pixel a menos para se encaixar dentro da caixa de cada quadrado
	inteiro x_un_table_special = x_un_table - 1
	inteiro y_un_table_special = y_un_table - 1

	logico concluir_nivel = falso
	// define quando deve repetir ou não o sorteio do resultado do quadrado das matrizes
	logico ignorarSorteio = falso
	// define o valor aleatorio para o resultado dos diferentes quadrados da matriz
	cadeia valorSorte = ""

	cadeia adivinha_num[9]
	cadeia UNASSIGNED = ""
	inteiro valorSorteado = 0

	
	/* Variáveis referentes diretamente à matriz 9x9 */
	const inteiro numero_linhas=9, numero_colunas=9
	inteiro linha = 0, coluna = 0, linhas = 0, colunas = 0
	/* Variáis para escolher o nível */
	logico escolheu_nivel = falso
	inteiro nivel = 0
	
	/* Matriz que armazena a informação de quais quadrados estão já preenchidos dependendo do nível selecionado */
	logico matriz_niveis[numero_linhas][numero_colunas] =
		 {
		 	/* Colunas -> */ /*0*/  /*1*/  /*2*/  /*3*/  /*4*/  /*5*/  /*6*/  /*7*/  /*8*/  /* Linhas */
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*0*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*1*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*2*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*3*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*4*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*5*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*6*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*7*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}  /*8*/
		 }
	// numeros criados aleatoriamente do puzzle
	cadeia numeros_nivel[numero_linhas][numero_colunas] =
		{
			/* Colunas ->   0   1   2   3   4   5   6   7   8   Linhas */
		 				{"", "", "", "", "", "", "", "", ""}, /*0*/
		 				{"", "", "", "", "", "", "", "", ""}, /*1*/
		 				{"", "", "", "", "", "", "", "", ""}, /*2*/
		 				{"", "", "", "", "", "", "", "", ""}, /*3*/
		 				{"", "", "", "", "", "", "", "", ""}, /*4*/
		 				{"", "", "", "", "", "", "", "", ""}, /*5*/
		 				{"", "", "", "", "", "", "", "", ""}, /*6*/
		 				{"", "", "", "", "", "", "", "", ""}, /*7*/
		 				{"", "", "", "", "", "", "", "", ""}  /*8*/
		}
		 
	
	/*
	 * Matriz que armazena as variáveis de controlo dos quadrados do Sudoku
	 * Sempre que selecionada um dos quadros para preencher o Sudoku, uma das posições da matriz abaixo é modificada
	 */
	 logico matriz_jogo[numero_linhas][numero_colunas] =
		 {
		 	/* Colunas -> */ /*0*/  /*1*/  /*2*/  /*3*/  /*4*/  /*5*/  /*6*/  /*7*/  /*8*/  /* Linhas */
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*0*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*1*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*2*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*3*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*4*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*5*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*6*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*7*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}  /*8*/
		 }

	logico matriz_escolhas[numero_linhas][numero_colunas] =
		 {
		 	/* Colunas -> */ /*0*/  /*1*/  /*2*/  /*3*/  /*4*/  /*5*/  /*6*/  /*7*/  /*8*/  /* Linhas */
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*0*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*1*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*2*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*3*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*4*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*5*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*6*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}, /*7*/
		 				{falso, falso, falso, falso, falso, falso, falso, falso, falso}  /*8*/
		 }

	/* Variáveis para o número escolhido e possiveis de ser aceitei pela máquina  */
	inteiro tecla_escolhida = 0
	inteiro teclas_possiveis[] = {49,50,51,52,53,54,55,56,57}
	inteiro no = 0
	// numeros submetidos pelo Jogador
	cadeia numero_aceite[numero_linhas][numero_colunas] =
		{
			/* Colunas ->   0   1   2   3   4   5   6   7   8   Linhas */
		 				{"", "", "", "", "", "", "", "", ""}, /*0*/
		 				{"", "", "", "", "", "", "", "", ""}, /*1*/
		 				{"", "", "", "", "", "", "", "", ""}, /*2*/
		 				{"", "", "", "", "", "", "", "", ""}, /*3*/
		 				{"", "", "", "", "", "", "", "", ""}, /*4*/
		 				{"", "", "", "", "", "", "", "", ""}, /*5*/
		 				{"", "", "", "", "", "", "", "", ""}, /*6*/
		 				{"", "", "", "", "", "", "", "", ""}, /*7*/
		 				{"", "", "", "", "", "", "", "", ""}  /*8*/
		}

	cadeia matriz_quadrados_grandes[numero_linhas][numero_colunas] =
		{
			/* Colunas ->   0   1   2   3   4   5   6   7   8   Linhas */
		 				{"0", "0", "0", "1", "1", "1", "2", "2", "2"}, /*0*/
		 				{"0", "0", "0", "1", "1", "1", "2", "2", "2"}, /*1*/
		 				{"0", "0", "0", "1", "1", "1", "2", "2", "2"}, /*2*/
		 				{"3", "3", "3", "4", "4", "4", "5", "5", "5"}, /*3*/
		 				{"3", "3", "3", "4", "4", "4", "5", "5", "5"}, /*4*/
		 				{"3", "3", "3", "4", "4", "4", "5", "5", "5"}, /*5*/
		 				{"6", "6", "6", "7", "7", "7", "8", "8", "8"}, /*6*/
		 				{"6", "6", "6", "7", "7", "7", "8", "8", "8"}, /*7*/
		 				{"6", "6", "6", "7", "7", "7", "8", "8", "8"}  /*8*/
		}
		 
	const inteiro num_linha_provisorio=3, num_coluna_provisorio=3
	cadeia num_prov
	inteiro num_provisorio = 0
	inteiro mini_x_prov = 0, mini_y_prov = 0
	inteiro coluna_d_prov = 0, linha_d_prov = 0
	logico matriz_provisorio[27][27] =
		 {
		 	/* Colunas -> */ /*0*/  /*1*/  /*2*/  /* Linhas */
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso},
			{falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso, falso}
		 }

	
	funcao inicio()
	{
		inicializar()
		executar()
		finalizar()
	}

	funcao inicializar()
	{
		// Inicializando o modo gráfico
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Sudoku")
		altura_tela = g.altura_tela()
		largura_tela = g.largura_tela()
		g.definir_dimensoes_janela(largura_tela, altura_tela)
		recalibrar_jogo()
	}

	funcao recalibrar_jogo()
	{
		x_inc_tabela = (largura_tela / 2) - (4.5 * x_un_table)
		y_inc_tabela = (altura_tela / 2) - (4.5 * y_un_table)
	}
	
	funcao executar()
	{
		enquanto (nao te.tecla_pressionada(te.TECLA_ESC))
		{			
			confirmar_mouse_hover()
			tratar_cliques()
			desenhar()
		}
	}

	funcao desenha_fundo_branco()
	{
		/* Fundo branco */
		g.definir_cor(-1)
		g.desenhar_retangulo(0, 0, largura_tela, altura_tela, falso, verdadeiro)
	}

	funcao desenhar_menu()
	{
		// Desenha "Sudoku"
		desenha_titulo()
		// Desenha "Novo Jogo"
		desenha_novo_jogo()
		// Denha retangulo de novo jogo.
		desenha_retangulo_nivel()
	}

	funcao desenha_titulo()
	{
		cadeia titulo = "Sudoku"
		desenha_texto_progressivo(titulo, 150.0, 0.075)
	}

	funcao desenha_novo_jogo()
	{
		cadeia titulo = "Novo Jogo"
		desenha_texto_progressivo(titulo, 85.0, 0.2)
	}

	funcao desenha_retangulo_nivel()
	{
		cadeia texto1 = "Fácil"
		cadeia texto2 = "Médio"
		cadeia texto3 = "Difícil"

		//Nível Fácil
		se(caixa_nivel[0])
		{
			desenha_fundo_retangulo_por_cima(0.35, 0.15, 0.30, 0.35)
			desenha_texto_progressivo(texto1, 50.0, 0.425)
			desenha_retangulo_vazio(0.35, 0.15, 0.30, 0.35)
			caixa_nivel[0] = falso
		}
		senao
		{
			desenha_texto_progressivo(texto1, 50.0, 0.425)
			desenha_retangulo_vazio(0.35, 0.15, 0.30, 0.35)	
		}
		
		//Nível Médio
		se(caixa_nivel[1])
		{
			desenha_fundo_retangulo_por_cima(0.55, 0.15, 0.30, 0.35)
			desenha_texto_progressivo(texto2, 50.0, 0.625)
			desenha_retangulo_vazio(0.55, 0.15, 0.30, 0.35)
			caixa_nivel[1] = falso
		}
		senao
		{
			desenha_texto_progressivo(texto2, 50.0, 0.625)
			desenha_retangulo_vazio(0.55, 0.15, 0.30, 0.35)
		}
		
		//Nível Difícil
		se(caixa_nivel[2])
		{
			desenha_fundo_retangulo_por_cima(0.75, 0.15, 0.30, 0.35)
			desenha_texto_progressivo(texto3, 50.0, 0.825)
			desenha_retangulo_vazio(0.75, 0.15, 0.30, 0.35)
			caixa_nivel[2] = falso
		}
		senao
		{
			desenha_texto_progressivo(texto3, 50.0, 0.825)
			desenha_retangulo_vazio(0.75, 0.15, 0.30, 0.35)
		}
	}

	funcao desenha_texto_progressivo(cadeia texto, real tamanho_texto, real perct_top) 
	{
		//perct_top = percentagem de 1 a 0 entre o meio do texto e o top da janela de jogo, comparativamente ao tamanho total da janela
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(tamanho_texto)
		inteiro largura_texto = g.largura_texto(texto)
		inteiro altura_texto = g.altura_texto(texto)
		
		inteiro largura_inic_texto = (largura_tela / 2) - (largura_texto / 2)
		inteiro altura_inic_texto = (altura_tela * perct_top) - (altura_texto / 2)
		g.desenhar_texto(largura_inic_texto, altura_inic_texto, texto)
	}

	funcao desenha_retangulo_vazio(real top_top, real altura, real largura, real lados)
	{
		// top_top = top da caixa ate ao top da janela de jogo em percentagem entre 0 e 1
		// lados = percentagem de 1 a 0 de espaço vazio até à caixa da esquerda para a direita
		g.definir_cor(g.COR_PRETO)
		inteiro altura_caixa = altura_tela * altura
		inteiro largura_caixa = largura_tela * largura
		inteiro altura_inic_caixa = altura_tela * top_top
		inteiro largura_inic_caixa = largura_tela * lados
		
		g.desenhar_retangulo(largura_inic_caixa, altura_inic_caixa, largura_caixa, altura_caixa, falso, falso)
	}

	funcao desenha_fundo_retangulo_por_cima(real top_top, real altura, real largura, real lados)
	{
		inteiro altura_caixa_por_cima = (altura_tela * altura)
		inteiro largura_caixa_por_cima = (largura_tela * largura)
		inteiro altura_inic_caixa = altura_tela * top_top
		inteiro largura_inic_caixa = largura_tela * lados

		g.definir_cor(0xcccccc)
		g.desenhar_retangulo(largura_inic_caixa, altura_inic_caixa, largura_caixa_por_cima, altura_caixa_por_cima, falso, verdadeiro)
	}

	funcao desenhar_retangulo_validar()
	{
		desenha_retangulo_vazio(0.9, 0.05, 0.1, 0.6)
		cadeia texto = "Validar"
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(20.0)
		inteiro largura_texto = g.largura_texto(texto)
		inteiro altura_texto = g.altura_texto(texto)
		
		inteiro largura_inic_texto = (largura_tela * 0.65) - (largura_texto / 2)
		inteiro altura_inic_texto = (altura_tela * 0.925) - (altura_texto / 2)
		g.desenhar_texto(largura_inic_texto, altura_inic_texto, texto)
	}

	funcao desenhar_retangulo_voltar()
	{
		desenha_retangulo_vazio(0.9, 0.05, 0.1, 0.3)
		cadeia texto = "Voltar"
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(20.0)
		inteiro largura_texto = g.largura_texto(texto)
		inteiro altura_texto = g.altura_texto(texto)
		
		inteiro largura_inic_texto = (largura_tela * 0.35) - (largura_texto / 2)
		inteiro altura_inic_texto = (altura_tela * 0.925) - (altura_texto / 2)
		g.desenhar_texto(largura_inic_texto, altura_inic_texto, texto)
	}
	
	funcao desenha_clicou_direito(inteiro y, inteiro x)
	{
		g.definir_cor(g.COR_AMARELO)
		g.desenhar_retangulo(x, y, x_un_table, y_un_table, falso, verdadeiro)
	
		se(te.alguma_tecla_pressionada())
		{
			tecla_escolhida = te.ler_tecla()
			tecla_escolhida = ajustar_num(tecla_escolhida)
	
			para(no = 0;no <= 8;no++)
			{
				se(tecla_escolhida == teclas_possiveis[no])
				{
					matriz_provisorio[(linha*3) + mini_y_prov][(coluna*3) + mini_x_prov] = verdadeiro
					matriz_escolhas[linha][coluna] = falso
				}
				//127 representa a tecla_DELETE e o 8 é a de APAGAR
				// INICIO: Codigo que elimina qualquer valor, vindo do clique do lado direito, submetido antes
				senao se(tecla_escolhida == 127 ou tecla_escolhida == 8) 
				{
					matriz_provisorio[(linha*3) + mini_y_prov][(coluna*3) + mini_x_prov] = falso
					matriz_escolhas[linha][coluna] = falso
				}
				mini_x_prov++
				se(mini_x_prov==3)
				{
					mini_x_prov = 0
					mini_y_prov++
					se(mini_y_prov==3)
					{
						mini_y_prov = 0
					}
				}
				// FIM: Codigo que elimina qualquer valor, vindo do clique do lado direito, submetido antes
			}
		}
	}
	
	funcao desenha_clicou_esquerdo(inteiro y, inteiro x)
	{
		g.definir_cor(g.COR_AZUL)
		g.desenhar_retangulo(x, y, x_un_table, y_un_table, falso, verdadeiro)
		//escreva("esquerdo")
		se(te.alguma_tecla_pressionada())
		{
			tecla_escolhida = te.ler_tecla()
			tecla_escolhida = ajustar_num(tecla_escolhida)

			
			para(no = 0;no <= 8;no++)
			{
				se(tecla_escolhida == teclas_possiveis[no])
				{
					matriz_escolhas[linha][coluna] = verdadeiro
					numero_aceite[linha][coluna] = ti.caracter_para_cadeia(te.caracter_tecla(tecla_escolhida))
					mini_x_prov = 0
					mini_y_prov = 0

					// INICIO: Codigo que elimina qualquer valor, vindo do clique do lado direito, submetido antes
					para(no = 0;no <= 8;no++)
					{
						matriz_provisorio[(linha*3) + mini_y_prov][(coluna*3) + mini_x_prov] = falso
						mini_x_prov++
						se(mini_x_prov==3)
						{
							mini_x_prov = 0
							mini_y_prov++
							se(mini_y_prov==3)
							{
								mini_y_prov = 0
							}
						}
					}
					// FIM: Codigo que elimina qualquer valor, vindo do clique do lado direito, submetido antes
					
				}
				// INICIO: Confirma se a tecla precionada é para eliminar o conteudo
				senao se(tecla_escolhida == 127 ou tecla_escolhida == 8)
				{
					matriz_escolhas[linha][coluna] = falso
					para(no = 0;no <= 8;no++)
					{
						matriz_provisorio[(linha*3) + mini_y_prov][(coluna*3) + mini_x_prov] = falso

						mini_x_prov++
						se(mini_x_prov==3)
						{
							mini_x_prov = 0
							mini_y_prov++
							se(mini_y_prov==3)
							{
								mini_y_prov = 0
							}
						}
						
					}
				
				}
				// FIM: Confirma se a tecla precionada é para eliminar o conteudo
			}
		}
	}
	
	funcao desenha_cursor_cima(inteiro y, inteiro x)
	{
		//mancha
		g.definir_cor(0xcccccc)
		g.desenhar_retangulo(x+1, y+1, x_un_table_special, y_un_table_special, falso, verdadeiro)
		//reset ao quadrado
		matriz_jogo[linha][coluna]=falso
	}
	
	funcao desenha_esqueleto(inteiro y, inteiro x)
	{
		//Desenha o quadro do Sudoko quando selecionado(active)
		g.definir_cor(g.COR_PRETO)
		g.desenhar_retangulo(x, y, x_un_table, y_un_table, falso, falso)
	}
	
	funcao desenha_quadrado_permanente(inteiro y, inteiro x)
	{
		g.definir_cor(0x4d4d4d)
		g.desenhar_retangulo(x+1, y+1, x_un_table_special, y_un_table_special, falso, verdadeiro)
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(30.0)
		g.desenhar_texto(x+2, y+2, numeros_nivel[linha][coluna])
	}
	
	funcao desenha_valor_submetido(inteiro y, inteiro x)
	{
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(30.0)
		g.desenhar_texto(x+10, y+10, numero_aceite[linha][coluna])
		g.definir_tamanho_texto(10.0)
	}
	
	funcao desenhar_valor_provisorio(inteiro y, inteiro x)
	{
		para(no = 0;no <= 8;no++)
		{
			se(matriz_provisorio[(linha*3) + mini_y_prov][(coluna*3) + mini_x_prov])
			{
				g.definir_cor(g.COR_PRETO)
				g.definir_tamanho_texto(13.0)
				num_provisorio = 1
				cadeia num_prov_exemplo = ti.inteiro_para_cadeia (num_provisorio, 10)
				inteiro altura_texto_provi = g.altura_texto(num_prov_exemplo)
				inteiro largura_texto_provi = g.largura_texto(num_prov_exemplo)

				
				inteiro yy = y_inc_tabela + (y_un_table / 5) + (y_un_table*linha) - (altura_texto_provi / 2)
				num_provisorio = 1
				linha_d_prov = linha*3
				
				para (linhas=0;linhas<num_linha_provisorio;linhas++)
				{
					inteiro xx = x_inc_tabela + (x_un_table / 6) + (x_un_table*coluna) - (largura_texto_provi / 2)
					coluna_d_prov = coluna*3
					para (colunas=0;colunas<num_coluna_provisorio;colunas++)
					{
						num_prov = ti.inteiro_para_cadeia (num_provisorio, 10)
						se (matriz_provisorio[linha_d_prov][coluna_d_prov])
						{	
							g.definir_cor(g.COR_PRETO)
							g.desenhar_texto(xx, yy, num_prov)
						}
						
						coluna_d_prov++
						num_provisorio++
						se(num_provisorio == 10)
						{
							num_provisorio = 1
						}
						xx = xx + (x_un_table / 3)
					}
					yy = yy + (y_un_table / 3)
					linha_d_prov++
				}
			}
			mini_x_prov++
			se(mini_x_prov==3)
			{
				mini_x_prov = 0
				mini_y_prov++
				se(mini_y_prov==3)
				{
					mini_y_prov = 0
				}
			}
		}
	}
	
	funcao desenha_grande_parabens()
	{
		cadeia final = "PARABÉNS"
		desenha_texto_progressivo(final, 200.0, 0.5)
	}
	
	funcao desenhar()
	{	
		desenha_fundo_branco()

		se(nao parabens)
		{
			se (escolheu_nivel e nao voltar_menu_principal)
			{
			
				g.definir_cor(g.COR_PRETO)
				inteiro y = y_inc_tabela
				para (linha = 0; linha < numero_linhas; linha++)
				{
					inteiro x = x_inc_tabela
					para (coluna = 0; coluna < numero_colunas; coluna++)
					{
						//Desenha quadrado de seleção quando CLICADO LADO DIREITO
						se(clicou_direito e matriz_jogo[linha][coluna] e Xclicado == linha e Yclicado == coluna e nao matriz_niveis[linha][coluna])
						{
							desenha_clicou_direito(y, x)
						}
						
						//Desenha quadrado de seleção quando CLICADO LADO ESQUERDO
						senao se(clicou_esquerdo e matriz_jogo[linha][coluna] e Xclicado == linha e Yclicado == coluna e nao matriz_niveis[linha][coluna])
						{
							desenha_clicou_esquerdo(y, x)
						}
						//Desenha o quadro do Sudoko quando o cursor se localiza em cima dele(hover)
						senao se(matriz_jogo[linha][coluna] e nao matriz_niveis[linha][coluna])
						{
							desenha_cursor_cima(y, x)
						}
						//Desenha o quadro do Sudoko quando selecionado(active)
						desenha_esqueleto(y, x)
						//Desenha os quadrados fixos e inalteráveis do nível
						se(matriz_niveis[linha][coluna])
						{
							desenha_quadrado_permanente(y, x)
						}
						//Desenha o valor colocado pelo Jogador
						se(matriz_escolhas[linha][coluna])
						{
							desenha_valor_submetido(y, x)
						}
						//Desenha os valores provisórios colocados pelo Jogador
						desenhar_valor_provisorio(y, x)
										
						x=x+x_un_table
						g.definir_cor(g.COR_PRETO)
					}
					y=y+y_un_table
				}
	
				desenhar_retangulo_validar()
				desenhar_retangulo_voltar()
			}
			senao se(nao escolheu_nivel ou voltar_menu_principal)
			{
				g.definir_cor(g.COR_PRETO)
				desenhar_menu()
				escolher_nivel()
			}
		}
		senao
		{
			desenha_grande_parabens()
		}
		g.renderizar()
		se(parabens)
		{
			u.aguarde(3000)
			parabens = falso
		}
	}
	
	funcao tratar_cliques()
	{
		se(escolheu_nivel)
		{
			se (Mouse.algum_botao_pressionado())
			{
				inteiro altura_inic_caixa = altura_tela * 0.9
				inteiro altura_caixa = altura_tela * 0.05
				inteiro largura_caixa = largura_tela * 0.1
				inteiro largura_inic_caixa_voltar = largura_tela * 0.30
				inteiro largura_inic_caixa_validar = largura_tela * 0.6

				
				botao_escolhido = m.ler_botao()
				se(botao_escolhido == 1 e (m.posicao_y() >= y_inc_tabela e m.posicao_y() <= y_un_table * numero_colunas + y_inc_tabela  e 
								       m.posicao_x() >= x_inc_tabela e m.posicao_x() <= x_un_table * numero_linhas + x_inc_tabela))
				{
					clicou_direito = verdadeiro
					clicou_esquerdo = falso
					Xclicado = Xhover 
					Yclicado = Yhover
				}
				senao se (botao_escolhido == 0 e (m.posicao_y() >= y_inc_tabela e m.posicao_y() <= y_un_table * numero_colunas + y_inc_tabela e 
									         m.posicao_x() >= x_inc_tabela e m.posicao_x() <= x_un_table * numero_linhas + x_inc_tabela))
				{
					clicou_esquerdo = verdadeiro
					clicou_direito = falso
					Xclicado = Xhover 
					Yclicado = Yhover
				}
				senao se(por_cima_voltar e botao_escolhido == 0 e (m.posicao_x() > largura_inic_caixa_voltar e m.posicao_x() < (largura_inic_caixa_voltar + largura_caixa)  e 
				m.posicao_y() > altura_inic_caixa e m.posicao_y() < (altura_inic_caixa + altura_caixa)))
				{
					voltar_menu_principal = verdadeiro
					escolheu_nivel = falso

					para(inteiro i = 0; i < 9; i++)
					{
						para(inteiro j = 0; j < 9; j++)
						{
							numeros_nivel[i][j]=""
						}
					}

					para(inteiro i = 0; i < 9; i++)
					{
						para(inteiro j = 0; j < 9; j++)
						{
							matriz_niveis[i][j]= falso
						}
					}
					
				}
				senao se(por_cima_validar e botao_escolhido == 0 e(m.posicao_x() > largura_inic_caixa_validar e m.posicao_x() < (largura_inic_caixa_validar + largura_caixa)  e 
			m.posicao_y() > altura_inic_caixa e m.posicao_y() < (altura_inic_caixa + altura_caixa)))
				{
					logico concluir = validar()
					se(concluir)
					{
						parabens = verdadeiro
					}
					senao
					{
						
					}
				}
				senao
				{
					Xclicado = -1
					Yclicado = -1
				} 
				
			}
		}
		senao
		{
			se (Mouse.algum_botao_pressionado())
			{
				botao_escolhido = m.ler_botao()
				inteiro largura_inic_caixa = largura_tela * 0.35
				inteiro altura_caixa = altura_tela * 0.15
				inteiro largura_caixa = largura_tela * 0.30
				

				// caixa menu - Fácil
				inteiro altura_inic_caixa1 = altura_tela * (0.35)
				// caixa menu - Médio
				inteiro altura_inic_caixa2 = altura_tela * (0.55)
				// caixa menu - Difícil
				inteiro altura_inic_caixa3 = altura_tela * (0.75)
				
				se(botao_escolhido == 0 e (m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e 
				m.posicao_y() > altura_inic_caixa1 e m.posicao_y() < (altura_inic_caixa1 + altura_caixa)))
				{
					cursor_clicou = cursor_hover
					voltar_menu_principal = falso
				}
				senao se(botao_escolhido == 0 e (m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e 
				m.posicao_y() > altura_inic_caixa2 e m.posicao_y() < (altura_inic_caixa2 + altura_caixa)))
				{
					cursor_clicou = cursor_hover
					voltar_menu_principal = falso
				}
				senao se(botao_escolhido == 0 e (m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e 
				m.posicao_y() > altura_inic_caixa3 e m.posicao_y() < (altura_inic_caixa3 + altura_caixa)))
				{
					cursor_clicou = cursor_hover
					voltar_menu_principal = falso
				}
				senao
				{
					cursor_clicou = -1
				}
			}
			senao se(voltar_menu_principal)
			{
				cursor_clicou = -1
			}
		}
	}

	funcao confirmar_mouse_hover()
	{
		se(escolheu_nivel)
		{
			inteiro y = y_inc_tabela
			para (linha = 0; linha < numero_linhas; linha++)
			{
				se(m.posicao_y() > y e m.posicao_y() < y+y_un_table)
				{
					inteiro x = x_inc_tabela
					Xhover = linha
					
					para (coluna = 0; coluna < numero_colunas; coluna++)
					{
						se(m.posicao_x() > x e m.posicao_x() < x+x_un_table)
						{
							matriz_jogo[linha][coluna] = verdadeiro		
							Yhover = coluna	
						}
						x=x+x_un_table
					}
				}
				y=y+y_un_table
			}
			
			inteiro altura_inic_caixa = altura_tela * 0.9
			inteiro altura_caixa = altura_tela * 0.05
			inteiro largura_caixa = largura_tela * 0.1

			/* Confirmar se está em cima do rectangulo Validar */ /*FUNCIONA */
			inteiro largura_inic_caixa_validar = largura_tela * 0.6
			se(m.posicao_x() > largura_inic_caixa_validar e m.posicao_x() < (largura_inic_caixa_validar + largura_caixa)  e 
			m.posicao_y() > altura_inic_caixa e m.posicao_y() < (altura_inic_caixa + altura_caixa))
			{
				por_cima_validar = verdadeiro
			}

			/* Confirmar se está em cima do rectangulo Validar */ /*FUNCIONA */
			inteiro largura_inic_caixa_voltar = largura_tela * 0.30
			se(m.posicao_x() > largura_inic_caixa_voltar e m.posicao_x() < (largura_inic_caixa_voltar + largura_caixa)  e 
			m.posicao_y() > altura_inic_caixa e m.posicao_y() < (altura_inic_caixa + altura_caixa))
			{
				por_cima_voltar = verdadeiro
			}
		}
		senao
		{
			inteiro largura_inic_caixa = largura_tela * 0.35
			inteiro altura_caixa = altura_tela * 0.15
			inteiro largura_caixa = largura_tela * 0.30
				
			// caixa menu - Fácil
			inteiro altura_inic_caixa1 = altura_tela * 0.35
			se(m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e 
			m.posicao_y() > altura_inic_caixa1 e m.posicao_y() < (altura_inic_caixa1 + altura_caixa))
			{
				cursor_hover = 1
				caixa_nivel[0] = verdadeiro
				
			}

			// caixa menu - Médio
			inteiro altura_inic_caixa2 = altura_tela * 0.55
			se(m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e m.posicao_y() > altura_inic_caixa2 e m.posicao_y() < (altura_inic_caixa2 + altura_caixa))
			{
				cursor_hover = 2
				caixa_nivel[1] = verdadeiro
				
			}

			// caixa menu - Difícil
			inteiro altura_inic_caixa3 = altura_tela * 0.75
			se(m.posicao_x() > largura_inic_caixa e m.posicao_x() < (largura_inic_caixa + largura_caixa)  e m.posicao_y() > altura_inic_caixa3 e m.posicao_y() < (altura_inic_caixa3 + altura_caixa))
			{
				cursor_hover = 3
				caixa_nivel[2] = verdadeiro
				
			}
		}
	}
	
	funcao logico validar()
	{
		para (linha = 0; linha < numero_linhas; linha++)
		{
			para (coluna = 0; coluna < numero_colunas; coluna++)
			{
				se(matriz_niveis[linha][coluna])
				{
					numero_aceite[linha][coluna] = numeros_nivel[linha][coluna]
				}
				se(numero_aceite[linha][coluna] != numeros_nivel[linha][coluna])
				{
					retorne falso
				}
			}
		}
		retorne verdadeiro
	}

	funcao escolher_nivel()
	{
		inteiro nivel_escolhido = 0
		nivel = cursor_clicou 
		se(voltar_menu_principal)
		{
			nivel = -1
		}
		
		escolha(nivel)
		{
			caso 1:
			nivel_escolhido = 35
			pare
			caso 2:
			nivel_escolhido = 30
			pare
			caso 3:
			nivel_escolhido = 25
			pare
		}
		
		se(nivel > 0)
		{
			sorteia_valores_aleatorios()
			sorteia_definitivo(nivel_escolhido)
			escolheu_nivel = verdadeiro
		}
	}


	funcao sorteia_valores_aleatorios()
	{
		para(inteiro i = 0; i < 9; i++)
		{
			faca
			{
				ignorarSorteio = falso
				adivinha_num[i] = ti.inteiro_para_cadeia(u.sorteia(1, 9), 10)
				para(inteiro j = 0; j < i; j++)
					{
						se(adivinha_num[i] == adivinha_num[j])
						{
							ignorarSorteio = verdadeiro
						}
					}
			}enquanto(ignorarSorteio)
		}

		resolver_grelha_sudoku()
	}

	funcao logico encontrar_quadrado_sem_valor(cadeia gridd[][], inteiro &row, inteiro &col)
		{
			para(row = 0; row < 9; row++)
			{
				para(col = 0; col < 9; col++)
				{
					se(gridd[row][col] == UNASSIGNED)
					{
						retorne verdadeiro
					}
				}
			}
			retorne falso
		}
	
	// CONFIRMA REGRA DA LINHA
	funcao logico usado_linha(cadeia gridd[][], inteiro row, cadeia numero)
	{
		para(inteiro col = 0; col < 9; col++)
		{
			se(gridd[row][col] == numero)
			{
				retorne verdadeiro
			}
		}
		retorne falso
	}
	
	// CONFIRMA REGRA DA COLUNA
	funcao logico usado_coluna(cadeia gridd[][], inteiro col, cadeia numero)
	{
		para(inteiro row = 0; row < 9; row++)
		{
			se(gridd[row][col] == numero)
			{
				retorne verdadeiro
			}
		}
		retorne falso
	}

	// CONFIRMA REGRA DO QUADRADO GRANDE
	funcao logico usado_quadrado_grande(cadeia gridd[][], inteiro boxStartRow, inteiro boxStartCol, cadeia numero)
	{
		para(inteiro row = 0; row < 3; row++)
		{
			para(inteiro col = 0; col < 3; col++)
			{
				se(gridd[row + boxStartRow][col + boxStartCol] == numero)
				{
					retorne verdadeiro
				}
			}
		}
		retorne falso
	}

	// INICIA AS REGRAS E SÓ AVANÇA SE TIVEREM AS TRÊS CORRETAS
	funcao logico testa_regras(cadeia gridd[][], inteiro row, inteiro col, cadeia numero)
	{
		retorne nao usado_linha(gridd, row, numero) e nao usado_coluna(gridd, col, numero) e nao usado_quadrado_grande(gridd, row - row%3, col - col%3, numero)
	}

	// END: Helper functions for solving grid

	// START: Modified and improved Sudoku solver
	funcao logico resolver_grelha_sudoku()
	{
		inteiro row = 0, col = 0

		// If there is no unassigned location, we are done
		se(nao encontrar_quadrado_sem_valor(numeros_nivel, row, col))
		{
    			retorne verdadeiro // success!
		}

		/*escreva("\n", row,"  ",col)*/
		
		// Consider digits 1 to 9
		para(inteiro num = 0; num < 9; num ++)
		{
			//se parecer promissor
			se(testa_regras(numeros_nivel, row, col, adivinha_num[num]))
			{
				// make tentative assignment
				numeros_nivel[row][col] = adivinha_num[num]

				// return, se sucesso, yay!
				se(resolver_grelha_sudoku())
				{
					retorne verdadeiro
				}

				// failure, unmake & try again
				numeros_nivel[row][col] = UNASSIGNED
			}
			//escreva("\n", row,"  ",col)
		}
		manter_valores(numeros_nivel, row, col)
		retorne falso // this triggers backtracking
	}
	// END: Modified and improved Sudoku Solver

	funcao manter_valores(cadeia gridd[][], inteiro &row, inteiro &col)
	{
		se(row == 8 e col == 8)
		{
			retorne
		}
		senao se(col == 0)
		{
			row = row - 1
			col = 8
		}
		senao
		{
			col = col - 1
		}
	}

	funcao sorteia_definitivo(inteiro nivel_escolhido)
	{
	  	para(inteiro i = 0; i < nivel_escolhido; i++)
	  	{
			faca
			{
				ignorarSorteio = falso
				inteiro linhaSorteada = u.sorteia(0,8)
				inteiro colunaSorteada = u.sorteia(0,8)

				// Confirma se o quadrado já foi escolhido. Se sim, pede novos valores. Se não, avança e guarda o quadrado
				se(matriz_niveis[linhaSorteada][colunaSorteada])
				{
					ignorarSorteio = verdadeiro
				}
				senao
				{
					matriz_niveis[linhaSorteada][colunaSorteada] = verdadeiro
				}
			}enquanto(ignorarSorteio)
	  	}
  	}
	
	
	funcao guardar_num_provisorio(inteiro num, logico matriz[][])
	{
		escolha(num)
		{
			caso 49:
			matriz[0][0] = verdadeiro
			pare
			caso 50:
			matriz[0][1] = verdadeiro
			pare
			caso 51:
			matriz[0][2] = verdadeiro
			pare
			caso 52:
			matriz[1][0] = verdadeiro
			pare
			caso 53:
			matriz[1][1] = verdadeiro
			pare
			caso 54:
			matriz[1][2] = verdadeiro
			pare
			caso 55:
			matriz[2][0] = verdadeiro
			pare
			caso 56:
			matriz[2][1] = verdadeiro
			pare
			caso 57:
			matriz[2][2] = verdadeiro
			pare
		}

	}
	
	funcao inteiro ajustar_num(inteiro num_ajustar)
	{
		escolha (num_ajustar)
		{
			caso 97:
			num_ajustar = 49 
			pare
			caso 98:
			num_ajustar = 50 
			pare
			caso 99:
			num_ajustar = 51 
			pare
			caso 100:
			num_ajustar = 52 
			pare
			caso 101:
			num_ajustar = 53 
			pare
			caso 102:
			num_ajustar = 54 
			pare
			caso 103:
			num_ajustar = 55 
			pare
			caso 104:
			num_ajustar = 56 
			pare
			caso 105:
			num_ajustar = 57 
			pare
		}
		retorne num_ajustar
	}
	
	
	funcao finalizar ()
	{
		g.encerrar_modo_grafico()
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5596; 
 * @DOBRAMENTO-CODIGO = [227, 234, 244, 250, 256, 305, 318, 331, 342, 356, 370, 409, 474, 483, 490, 507, 563, 569, 644, 846, 865, 896, 917, 946, 959, 975, 983, 1020, 1037, 1061, 1096];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
