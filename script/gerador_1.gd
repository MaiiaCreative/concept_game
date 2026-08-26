extends Node2D


# Carrega a cena do inimigo que você já criou
var inimigo_cena = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	Global.generate_enemy = true

func _on_timer_timeout() -> void:
	if Global.generate_enemy:
		
		# Aumentamos a quantidade: agora nascem de 8 a 15 inimigos de uma vez!
		var quantidade_por_tiro = randi_range(8, 15) 
		
		for i in range(quantidade_por_tiro):
			var inimigo = inimigo_cena.instantiate()
			
			# Sorteia de qual borda da tela o inimigo vai nascer (0=Topo, 1=Fundo, 2=Esquerda, 3=Direita)
			var borda = randi() % 4
			
			if borda == 0:
				inimigo.position = Vector2(randf_range(0, 1344), -50) # Nasce no Topo
			elif borda == 1:
				inimigo.position = Vector2(randf_range(0, 1344), 818) # Nasce no Fundo (768 + 50)
			elif borda == 2:
				inimigo.position = Vector2(-50, randf_range(0, 768)) # Nasce na Esquerda
			else:
				inimigo.position = Vector2(1394, randf_range(0, 768)) # Nasce na Direita (1344 + 50)
			
			# Sorteia a direção para onde ele vai apontar
			var direcoes_possiveis = [
				Vector2.DOWN, Vector2.UP, Vector2.LEFT, Vector2.RIGHT,
				Vector2(1, 1).normalized(), Vector2(-1, 1).normalized(),
				Vector2(1, -1).normalized(), Vector2(-1, -1).normalized()
			]
			
			inimigo.direcao = direcoes_possiveis.pick_random()
			get_tree().current_scene.add_child(inimigo)
