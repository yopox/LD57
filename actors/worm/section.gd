class_name WormSection extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var face: Sprite2D = $Face

@export var is_face: bool = false

var last_pos: Vector2 = Vector2.ZERO
var colors = [
	Color.hex(0xee8fcbff),
	Color.hex(0xd46eb3ff),
]


func _ready() -> void:
	face.texture = face.texture.duplicate()
	(face.texture as AtlasTexture).region.position.x = 0
	face.visible = is_face
	sprite.modulate = colors.pick_random()
