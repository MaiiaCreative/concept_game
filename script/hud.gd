extends CanvasLayer


@onready var score_label = $ScoreLabel

func _process(_delta: float) -> void:
	if score_label:
		# Exibe exatamente igual ao jogo original: "SCORE: [número]"
		score_label.text = "SCORE: " + str(Global.score)
