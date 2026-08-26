extends Camera2D


# Configurações do tremor
var forca_tremor : float = 15.0
var recuperacao : float = 5.0

func _process(delta: float) -> void:
	# O script lê a variável shake_value que você já declarou no global.gd
	if Global.shake_value > 0:
		# Gera um desvio aleatório no eixo X e Y
		var offset_x = randf_range(-1.0, 1.0) * Global.shake_value * forca_tremor
		var offset_y = randf_range(-1.0, 1.0) * Global.shake_value * forca_tremor
		offset = Vector2(offset_x, offset_y)
		
		# Reduz gradativamente o shake_value até chegar a zero
		Global.shake_value = move_toward(Global.shake_value, 0.0, recuperacao * delta)
	else:
		# Garante que a câmera volte perfeitamente para o centro quando o tremor parar
		offset = Vector2.ZERO
