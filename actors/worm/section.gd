class_name WormSection extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var face: Sprite2D = $Face

@export var distance: float = 2.99
@export var colors: Array[Color] = [
	Color.hex(0xee8fcbff),
	Color.hex(0xd46eb3ff),
]

var last_pos: Vector2 = Vector2.ZERO


func _ready() -> void:
	sprite.modulate = colors.pick_random()
