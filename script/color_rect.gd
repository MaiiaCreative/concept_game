extends ColorRect


func _ready() -> void:
	# Começa totalmente transparente
	color.a = 0.0

func _process(delta: float) -> void:
	# Verifica se o gatilho do flash foi ativado
	if Global.flash:
		color.a = Global.flash_alpha
		Global.flash = false # Desliga o gatilho imediatamente para não travar
		
	# Se a tela estiver branca, vai esmaecendo com o tempo
	if color.a > 0:
		color.a = move_toward(color.a, 0.0, 1.5 * delta) # O 1.5 define a velocidade de sumiço
