extends Area2D


var explosao_cena = preload("res://scenes/explosao.tscn")
var direcao = Vector2.DOWN  

func _physics_process(delta):
	if not Global.timestop:
		position += direcao * Global.enemy_speed * 60 * delta
		rotation = direcao.angle()

# Mude de body_entered para area_entered (já que o inimigo e o player são Area2D)
func _on_area_entered(area: Area2D) -> void:
	# Verifique se o nome do nó que encostou é "Player"
	if area.name == "Player":
		
		# Verifica se o jogador não está protegido
		if not area.is_invincible and not Global.super_invincibility:
			area.HP -= 1
			area.is_invincible = true
			# Toca o som de dano no player
			AudioManager.get_node("SfxDamage").play()
			
		var explosao = explosao_cena.instantiate()
		explosao.global_position = global_position
		get_tree().current_scene.add_child(explosao)
		
		Global.score += 50
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func destruir_pelo_powerup() -> void:
	var explosao = explosao_cena.instantiate()
	explosao.global_position = global_position
	get_tree().current_scene.add_child(explosao)
	Global.score += 100
	queue_free()
