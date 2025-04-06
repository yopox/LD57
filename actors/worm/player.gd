extends Worm

@onready var face: Sprite2D = $Parts/s1/Face

var blocked: Dictionary[BlockMov.Type, int] = {}

enum State {
	BASE,
	CENTIPEDE_FOLLOWING,
	RING,
	GLASSES,
}


func _process(_delta: float) -> void:
	if not dir("w") and not dir("e") and not dir("d") and not dir("x") and not dir("z") and not dir("a"):
		return
	
	var direction = Vector2.ZERO
	if dir("w") and dir("e"):
		direction = Vector2.from_angle(-PI / 2)
	elif dir("e") and dir("d"):
		direction = Vector2.from_angle(-PI / 8)
	elif dir("d") and dir("x"):
		direction = Vector2.from_angle(PI / 8)
	elif dir("z") and dir("x"):
		direction = Vector2.from_angle(PI / 2)
	elif dir("a") and dir("z"):
		direction = Vector2.from_angle(7 * PI / 8)
	elif dir("w") and dir("a"):
		direction = Vector2.from_angle(-7 * PI / 8)
	elif dir("w"):
		direction = Vector2.from_angle(-3 * PI / 4)
	elif dir("e"):
		direction = Vector2.from_angle(-PI / 4)
	elif dir("d"):
		direction = Vector2.from_angle(0)
	elif dir("x"):
		direction = Vector2.from_angle(PI / 4)
	elif dir("z"):
		direction = Vector2.from_angle(3 * PI / 4)
	elif dir("a"):
		direction = Vector2.from_angle(PI)
	
	if direction.x > 0.0:
		face.position.x = 1.0
	elif direction.x < 0.0:
		face.position.x = -1.0
	
	if direction.y > 0.0:
		face.position.y = 0.0
	else:
		face.position.y = -1.0
	
	if blocked.has(BlockMov.Type.BLOCK_X_MINUS):
		direction.x = max(0, direction.x)
	if blocked.has(BlockMov.Type.BLOCK_X_PLUS):
		direction.x = min(0, direction.x)
	if blocked.has(BlockMov.Type.BLOCK_Y_MINUS):
		direction.y = max(0, direction.y)
	if blocked.has(BlockMov.Type.BLOCK_Y_PLUS):
		direction.y = min(0, direction.y)
	
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


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area is BlockMov:
		blocked[area.type] = 1


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area is BlockMov:
		blocked.erase(area.type)
