extends CharacterBody2D


# === MOVIMENTO ===
var spd = 400.0
var usando_mouse = true
var posicao_anterior_mouse = Vector2.ZERO

# === ATRIBUTOS ORIGINAIS ===
var HP = 3
var maxHP = 3

var is_invincible = false
var set_invencibilidade = 60 # Ajuste para o valor que estava no seu Create_0.gml
var invencibilidade = set_invencibilidade

var set_super_invencibilidade = 300
var super_invencibilidade = set_super_invencibilidade

var set_timestop = 180
var timestop = set_timestop

# === REFERÊNCIAS DE NÓS E IMAGENS ===
@onready var sprite = $Sprite2D
@onready var sfx_damage = $SfxDamage
@onready var sfx_shield_out = $SfxShieldOut

# Carregue os caminhos corretos das suas imagens
var tex_player = preload("res://assets/sprites/spr_player/spr_player.png")
var tex_player_selected = preload("res://assets/sprites/spr_player_selected/spr_player_selected.png")
var tex_player_invincible = preload("res://assets/sprites/spr_player_invincible/spr_player_invincible_2.png")

func _ready():
	posicao_anterior_mouse = get_global_mouse_position()

func _physics_process(_delta):
	_controle_movimento()
	_controle_sprites()
	_controle_hp_invencibilidade()
	_controle_power_ups()

# Funções separadas para manter o código organizado
func _controle_movimento():
	var mouse_atual = get_global_mouse_position()
	var direcao = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direcao != Vector2.ZERO:
		usando_mouse = false
	elif mouse_atual != posicao_anterior_mouse:
		usando_mouse = true
		
	if usando_mouse:
		global_position = mouse_atual
	else:
		velocity = direcao * spd
		move_and_slide()
		
	posicao_anterior_mouse = mouse_atual

func _controle_sprites():
	if Global.selecting == true:
		sprite.texture = tex_player_selected
	else:
		sprite.texture = tex_player

func _controle_hp_invencibilidade():
	if HP <= 0:
		AudioManager.get_node("SfxDeath").play()
		
		# Redireciona para a nova cena de Game Over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		
		queue_free()
		
	# --- ADICIONE ESTA PARTE QUE FALTAVA ABAIXO ---
	if HP > maxHP:
		HP = maxHP
		
	if is_invincible:
		if invencibilidade == set_invencibilidade: # Momento exato em que tomou o dano
			Global.shake_value = 1
			sfx_damage.play()
			
		invencibilidade -= 1
		sprite.modulate.a = 0.5 # Deixa o player transparente (piscando)
		
		if invencibilidade <= 0:
			is_invincible = false
			invencibilidade = set_invencibilidade
	else:
		sprite.modulate.a = 1.0 # Volta ao normal

func _controle_power_ups():
	if Global.menu == 1:
		if Global.super_invincibility:
			super_invencibilidade -= 1
			sprite.texture = tex_player_invincible
			
			if super_invencibilidade <= 0:
				super_invencibilidade = set_super_invencibilidade
				Global.super_invincibility = false
				sfx_shield_out.play()
				
	if Global.timestop:
		timestop -= 1
		if timestop <= 0:
			Global.timestop = false
			timestop = set_timestop
