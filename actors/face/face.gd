extends Sprite2D

enum Type {
	SMILE,
	SAD,
	SURPRISED,
	POKER,
	WORM,
}

@export var type: Type = Type.SMILE


func _ready() -> void:
	texture = texture.duplicate()
	match type:
		Type.SMILE: (texture as AtlasTexture).region.position.x = 0
		Type.SAD: (texture as AtlasTexture).region.position.x = 8
		Type.SURPRISED: (texture as AtlasTexture).region.position.x = 16
		Type.POKER: (texture as AtlasTexture).region.position.x = 24
		Type.WORM: (texture as AtlasTexture).region.position.x = 40
