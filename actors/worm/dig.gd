extends Node

@onready var worm: Worm = $".."
@onready var parts: Node2D = $"../Parts"
@export var mark_node: Node

var dirt = preload("res://actors/worm/dirt.tscn")


func _on_worm_worm_moved(pos: Vector2, disp: Vector2) -> void:
	for section: WormSection in parts.get_children():
		if section.global_position.y < 41.0: continue
		var dirt_mark: Node2D = dirt.instantiate()
		dirt_mark.position = worm.global_position + section.position - worm.head_pos
		mark_node.add_child(dirt_mark)
	
	var dirt_marks = mark_node.get_children()
	for i in range(0, dirt_marks.size() - 200 * parts.get_children().size()):
		dirt_marks[i].queue_free()
