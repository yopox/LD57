class_name Bubble extends Sprite2D

enum Type {
	SAD,
	HAPPY,
	EGG,
	ASLEEP,
	SHOCKED,
	LOVE,
}

@export var type: Type = Type.SAD : set = _set_type


func _set_type(value: Type) -> void:
	type = value
	update_bubble()


func _ready() -> void:
	texture = texture.duplicate()
	update_bubble()


func update_bubble() -> void:
	match type:
		Type.SAD: (texture as AtlasTexture).region.position.x = 0
		Type.HAPPY: (texture as AtlasTexture).region.position.x = 1 * 12
		Type.EGG: (texture as AtlasTexture).region.position.x = 2 * 12
		Type.ASLEEP: (texture as AtlasTexture).region.position.x = 3 * 12
		Type.SHOCKED: (texture as AtlasTexture).region.position.x = 4 * 12
		Type.LOVE: (texture as AtlasTexture).region.position.x = 5 * 12
