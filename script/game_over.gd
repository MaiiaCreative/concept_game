extends Control


@onready var score_label = $ScoreLabel

func _ready() -> void:
	# Soma os pontos coletados com bônus baseado no tempo de sobrevivência
	var pontos_finais = Global.score + (int(Global.tempo_sobrevivencia) * 5)
	
	score_label.text = "SCORE FINAL: " + str(pontos_finais)

func _input(event):
	var clicou_mouse = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	var apertou_restart = event.is_action_pressed("btn_start") or event.is_action_pressed("btn_action")
	
	if clicou_mouse or apertou_restart:
		# >>> COLOQUE ESTAS DUAS LINHAS AQUI ANTES DE MUDAR DE CENA <<<
		Global.score = 0
		Global.tempo_sobrevivencia = 0.0
		
		# Retorna para a fase principal do jogo
		get_tree().change_scene_to_file("res://scenes/fase_1.tscn")
