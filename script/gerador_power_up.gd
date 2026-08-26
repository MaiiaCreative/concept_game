extends Node2D


# Carrega a cena do power-up que acabamos de montar
var powerup_cena = preload("res://scenes/power_up.tscn")

func _on_timer_timeout() -> void:
	# Cria uma cópia do power-up
	var item = powerup_cena.instantiate()
	
	# Sorteia uma posição X e Y dentro do tamanho da sua tela (1344 x 768)
	# Coloquei de 50 a 1290 para ele não nascer grudado na parede
	var x_aleatorio = randf_range(50, 1294)
	var y_aleatorio = randf_range(50, 718)
	item.position = Vector2(x_aleatorio, y_aleatorio)
	
	# >>> DEFINA O TAMANHO AQUI <<<
	# Se quiser diminuir para a metade do tamanho atual, use Vector2(1.5, 1.5)
	# (Por padrão, se o sprite original for pequeno, testar Vector2(1.5, 1.5) ou Vector2(2, 2) costuma funcionar bem)
	item.scale = Vector2(0.8, 0.8)
	
	# Sorteia magicamente qual item vai ser (0 = Escudo, 1 = Relógio)
	item.tipo_powerup = randi() % 5
	
	# Coloca o item na tela
	get_tree().current_scene.add_child(item)
