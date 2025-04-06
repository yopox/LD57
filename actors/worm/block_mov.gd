class_name BlockMov extends Area2D

enum Type {
	BLOCK_X_MINUS,
	BLOCK_X_PLUS,
	BLOCK_Y_MINUS,
	BLOCK_Y_PLUS,
}

@export var type: Type = Type.BLOCK_X_MINUS
