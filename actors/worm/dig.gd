extends Node

@onready var worm: Worm = $".."
@onready var parts: Node2D = $"../Parts"
@export var mark_node: DirtContainer

var dirt = preload("res://actors/worm/dirt.tscn")


func _on_worm_worm_moved(pos: Vector2, disp: Vector2) -> void:
	var i = 0
	for section: WormSection in parts.get_children():
		if (i + 1) % 2 == 0: continue
		if section.global_position.y < 41.0: continue
		var dirt_mark: Dirt = dirt.instantiate()
		var p = worm.global_position + section.position - worm.head_pos
		dirt_mark.position = p
		mark_node.add_dirt_mark(dirt_mark)
	
	var dirt_marks = mark_node.get_children()
	for j in range(0, dirt_marks.size() - 50 * parts.get_children().size()):
		mark_node.dirt_marks[dirt_marks[j].key].erase(dirt_marks[j])
		dirt_marks[j].queue_free()
