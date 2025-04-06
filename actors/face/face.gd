extends Sprite2D

enum Type {
	WORM,
	POKER,
}

@export var type: Type = Type.WORM


func _ready() -> void:
	texture = texture.duplicate()
	match type:
		Type.WORM: (texture as AtlasTexture).region.position.x = 0
		Type.POKER: (texture as AtlasTexture).region.position.x = 8
