extends AnimatedSprite2D


func _on_animation_finished() -> void:
	queue_free() # A explosão some sozinha quando a animação acaba

	AudioManager.get_node("SfxPop").play()
