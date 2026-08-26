extends Area2D


# Permite escolher no editor qual power-up vai nascer (0 a 4)
@export var tipo_powerup: int = 0 
@onready var sprite = $Sprite2D

# Lista com os caminhos corretos de cada imagem
var texturas = [
	preload("res://assets/sprites/spr_invincible/spr_invincible_1.png"), # 0: Escudo
	preload("res://assets/sprites/spr_timestop/spr_timestop.png"),           # 1: Timestop
	preload("res://assets/sprites/spr_destroyer/spr_destroyer_1.png"),       # 2: Destroyer
	preload("res://assets/sprites/spr_life/spr_life.png"),                   # 3: Life
	preload("res://assets/sprites/spr_flash/spr_flash_1.png")                  # 4: Flash
]

func _ready() -> void:
	# Garante que o tipo sorteado está dentro do limite da lista
	if tipo_powerup >= 0 and tipo_powerup < texturas.size():
		sprite.texture = texturas[tipo_powerup]
		
		# Configura os quadros (frames) de acordo com o item
		if tipo_powerup == 2: # Se for o Destroyer
			sprite.hframes = 4  # 4 quadros na horizontal (ajuste para 2 se for grade 2x2)
			sprite.vframes = 1  # 1 linha (ajuste para 2 se for grade 2x2)
			sprite.frame = 0    # Começa no primeiro quadro inteiro
		else:
			sprite.hframes = 1  # Os outros itens usam apenas 1 frame estático
			sprite.vframes = 1
			sprite.frame = 0

func _process(_delta: float) -> void:
	# Animação fluida apenas para o Destroyer passar pelos 4 frames ciclicamente
	if tipo_powerup == 2:
		sprite.frame = int(Time.get_ticks_msec() / 150) % 4

# Detecta quando o Player encosta no power-up
# Como o Player é CharacterBody2D, usamos _on_body_entered
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		match tipo_powerup:
			0: efeito_escudo(body)
			1: efeito_timestop(body)
			2: efeito_destroyer(body)
			3: efeito_life(body)
			4: efeito_flash(body)
			
		# Toca o som de coleta padrão e some com o item
		AudioManager.get_node("SfxPop").play()
		queue_free()

# --- AÇÕES INDIVIDUAIS DE CADA POWER-UP ---

func efeito_escudo(player):
	Global.super_invincibility = true
	player.super_invencibilidade = player.set_super_invencibilidade
	AudioManager.get_node("SfxShieldIn").play()

func efeito_timestop(player):
	Global.timestop = true
	player.timestop = player.set_timestop
	AudioManager.get_node("SfxTimestop").play()

func efeito_destroyer(_player):
	get_tree().call_group("inimigos", "destruir_pelo_powerup")

func efeito_life(player):
	player.HP += 1

func efeito_flash(_player):
	Global.flash = true
	Global.flash_alpha = 0.8
	Global.shake_value = 1.0
	get_tree().call_group("inimigos", "destruir_pelo_powerup")
