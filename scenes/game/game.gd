extends Node2D

@onready var dirt: Node2D = $Dirt


func _ready() -> void:
	Util.dirt = dirt
