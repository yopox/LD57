class_name DirtContainer extends Node

var dirt_marks: Dictionary[Vector2i, Variant] = {}


func add_dirt_mark(mark: Dirt) -> void:
	var key = floor(mark.position / 4)
	key = Vector2i(key.x, key.y)
	mark.key = key
	var exists = false
	for m: Dirt in dirt_marks.get_or_add(key, []):
		if m.position == mark.position:
			exists = true
			move_child(m, 0)
	if not exists:
		dirt_marks.get_or_add(key, []).append(mark)
		add_child(mark)
	
	
