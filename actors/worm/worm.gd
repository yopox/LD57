class_name Worm extends Node2D

@onready var parts: Node2D = $Parts

var speed = 0.5
var head_pos = Vector2.ZERO

var dirt = preload("res://actors/worm/dirt.tscn")


func _process(delta: float) -> void:
	move()


func move():
	var moved = false
	
	var dx = Input.get_axis("left", "right")
	var dy = Input.get_axis("up", "down")
	
	if abs(dx) < 0.001 and abs(dy) < 0.001: return
	
	var move = Vector2(dx, dy).normalized() * speed
	var dist = speed
	
	if not dist > 0.001: return
	
	position += move
	parts.position -= move
	head_pos += move
	
	var prev_head = head_pos
	var z = Util.Z_WORM + parts.get_children().size()
	
	for section: WormSection in parts.get_children():
		var temp = section.position
		if section.position.distance_to(prev_head) > 3.0:
			var angle = temp.angle_to_point(prev_head)
			section.position = temp + Vector2.from_angle(angle) * dist
		section.z_index = z
		z -= 1
		
		# Make dirt dark
		var dirt_mark: Node2D = dirt.instantiate()
		dirt_mark.position = temp
		Util.dirt.add_child(dirt_mark)
		
		prev_head = temp
	
	var dirt_marks = Util.dirt.get_children()
	for i in range(0, dirt_marks.size() - 200 * parts.get_children().size()):
		dirt_marks[i].queue_free()
