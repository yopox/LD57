extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
var t: float = 0.0


func _process(delta: float) -> void:
	sprite.position.x = cos(t * 1.7)
	sprite.position.y = sin(t * 0.9)
	t += delta
