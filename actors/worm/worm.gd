class_name Worm extends Node2D

signal worm_moved(pos: Vector2, disp: Vector2)

@onready var parts: Node2D = $Parts

var speed = 0.5
var head_pos = Vector2.ZERO
var last_dir: Vector2 = Vector2.ZERO

var dirt = preload("res://actors/worm/dirt.tscn")


func _process(_delta: float) -> void:
	move()


func dir(d: String) -> bool:
	return Input.is_action_pressed(d)


func move():
	var pressed = 0
	if dir("e") and dir("r"):
		last_dir = Vector2.from_angle(-PI / 2)
	elif dir("r") and dir("f"):
		last_dir = Vector2.from_angle(-PI / 8)
	elif dir("f") and dir("c"):
		last_dir = Vector2.from_angle(PI / 8)
	elif dir("c") and dir("x"):
		last_dir = Vector2.from_angle(PI / 2)
	elif dir("s") and dir("x"):
		last_dir = Vector2.from_angle(7 * PI / 8)
	elif dir("e") and dir("s"):
		last_dir = Vector2.from_angle(-7 * PI / 8)
	elif dir("e"):
		last_dir = Vector2.from_angle(-3 * PI / 4)
	elif dir("r"):
		last_dir = Vector2.from_angle(-PI / 4)
	elif dir("f"):
		last_dir = Vector2.from_angle(0)
	elif dir("c"):
		last_dir = Vector2.from_angle(PI / 4)
	elif dir("x"):
		last_dir = Vector2.from_angle(3 * PI / 4)
	elif dir("s"):
		last_dir = Vector2.from_angle(PI)
	
	if not dir("e") and not dir("r") and not dir("f") and not dir("c") and not dir("x") and not dir("s"):
		return
	
	var displacement = last_dir * speed
	var dist = speed
	
	if not dist > 0.001: return
	
	position += displacement
	parts.position -= displacement
	head_pos += displacement
	worm_moved.emit(position, displacement)
	
	var prev_head = head_pos
	var z = Util.Z_WORM + parts.get_children().size()
	var first = true
	
	for section: WormSection in parts.get_children():
		var temp = section.position
		if first:
			section.position = prev_head
			first = false
		elif section.position.distance_to(prev_head) > 2.99:
			var angle = temp.angle_to_point(prev_head)
			section.position = temp + Vector2.from_angle(angle) * dist
		
		# Make dirt dark
		var dirt_mark: Node2D = dirt.instantiate()
		dirt_mark.position = position + temp - head_pos
		Util.dirt.add_child(dirt_mark)
		
		section.z_index = z
		z -= 1
		
		prev_head = temp
	
	var dirt_marks = Util.dirt.get_children()
	for i in range(0, dirt_marks.size() - 200 * parts.get_children().size()):
		dirt_marks[i].queue_free()
