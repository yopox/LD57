class_name WormSection extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var face: Sprite2D = $Face

@export var is_face: bool = false

func _ready() -> void:
	face.texture = face.texture.duplicate()
	(face.texture as AtlasTexture).region.position.x = 8 * (randi() % 11)
	face.visible = is_face
	sprite.modulate.g = randf_range(0.45, 0.55)
