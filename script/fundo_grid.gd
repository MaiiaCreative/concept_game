extends Node2D


# Configurações do nosso Grid
var tamanho_quadrado = 32 # O tamanho de cada quadradinho
var largura_tela = 1344
var altura_tela = 768

# Cores (no formato R, G, B, Opacidade)
var cor_fundo = Color(0.1, 0.1, 0.1, 1.0) # Um cinza quase preto
var cor_linha = Color(0.3, 0.3, 0.3, 1.0) # Cinza médio para as linhas do grid
var cor_borda = Color(1.0, 1.0, 1.0, 1.0) # Branco puro

func _draw():
	# 1. Pinta o fundo inteiro
	draw_rect(Rect2(0, 0, largura_tela, altura_tela), cor_fundo)

	# 2. Desenha as linhas verticais
	for x in range(0, largura_tela, tamanho_quadrado):
		draw_line(Vector2(x, 0), Vector2(x, altura_tela), cor_linha, 1.0)

	# 3. Desenha as linhas horizontais
	for y in range(0, altura_tela, tamanho_quadrado):
		draw_line(Vector2(0, y), Vector2(largura_tela, y), cor_linha, 1.0)

	# 4. Desenha a borda grossa e branca (o 'false' significa que ela é vazada por dentro)
	var espessura_borda = 6.0
	draw_rect(Rect2(0, 0, largura_tela, altura_tela), cor_borda, false, espessura_borda)
