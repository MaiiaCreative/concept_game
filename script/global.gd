extends Node


# Controle de Menus e Interface
var selecting = false
var menu = 1

# PONTUAÇÃO (Adicione esta linha)
var score = 0
var tempo_sobrevivencia = 0.0

# Controle de Inimigos
var generate_enemy = false
var enemy_speed = 7.0

# Velocidades e Temporizadores
var spd = 92.0
var sprite_spd = 0.0

# Power Ups
var power_up_time = 8.0
var super_invincibility = false
var timestop = false

# Efeitos (Flash e Screenshake)
var flash_alpha = 0.6
var flash = false
var shake_value = 0.0

# Dificuldade
var difficulty = 1
var difficulty_spd = 15.0
