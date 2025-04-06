extends AudioStreamPlayer

@onready var player: Node2D = $"../Player"


func _process(_delta: float) -> void:
	var y = player.global_position.y
	volume_linear = clamp(y / 500, 0, 1)
