extends Node2D


func _input(event):
	# Verifica se o jogador clicou com o botão esquerdo do mouse
	var clicou_mouse = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	
	# Verifica se o jogador apertou o botão Start (Enter) ou Ação (Z) que configuramos no Arcade
	var apertou_start = event.is_action_pressed("btn_start") or event.is_action_pressed("btn_action")
	
	# Se qualquer uma das ações acontecer, carrega a fase do jogo
	if clicou_mouse or apertou_start:
		get_tree().change_scene_to_file("res://scenes/fase_1.tscn")
