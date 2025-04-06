extends Worm

@onready var face: Sprite2D = $Parts/s1/Face


func _process(delta: float) -> void:
	if not dir("e") and not dir("r") and not dir("f") and not dir("c") and not dir("x") and not dir("s"):
		return
	
	var direction = Vector2.ZERO
	if dir("e") and dir("r"):
		direction = Vector2.from_angle(-PI / 2)
	elif dir("r") and dir("f"):
		direction = Vector2.from_angle(-PI / 8)
	elif dir("f") and dir("c"):
		direction = Vector2.from_angle(PI / 8)
	elif dir("c") and dir("x"):
		direction = Vector2.from_angle(PI / 2)
	elif dir("s") and dir("x"):
		direction = Vector2.from_angle(7 * PI / 8)
	elif dir("e") and dir("s"):
		direction = Vector2.from_angle(-7 * PI / 8)
	elif dir("e"):
		direction = Vector2.from_angle(-3 * PI / 4)
	elif dir("r"):
		direction = Vector2.from_angle(-PI / 4)
	elif dir("f"):
		direction = Vector2.from_angle(0)
	elif dir("c"):
		direction = Vector2.from_angle(PI / 4)
	elif dir("x"):
		direction = Vector2.from_angle(3 * PI / 4)
	elif dir("s"):
		direction = Vector2.from_angle(PI)
	
	if direction.x > 0.0:
		face.position.x = 1.0
	elif direction.x < 0.0:
		face.position.x = -1.0
	
	if direction.y > 0.0:
		face.position.y = 0.0
	else:
		face.position.y = -1.0
	
	move(direction)
	add_dirt()


func add_dirt() -> void:
	for section: WormSection in parts.get_children():
		var dirt_mark: Node2D = dirt.instantiate()
		dirt_mark.position = position + section.position - head_pos
		Util.dirt.add_child(dirt_mark)
	
	var dirt_marks = Util.dirt.get_children()
	for i in range(0, dirt_marks.size() - 200 * parts.get_children().size()):
		dirt_marks[i].queue_free()
