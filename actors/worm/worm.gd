class_name Worm extends Node2D

signal worm_moved(pos: Vector2, disp: Vector2)

@export var parts: Node2D
@export var speed = 0.5

var head_pos = Vector2.ZERO


func dir(d: String) -> bool:
	return Input.is_action_pressed(d)


func move(direction: Vector2):
	var displacement = direction * speed
	var dist = speed
	
	position += displacement
	parts.position -= displacement
	head_pos += displacement
	worm_moved.emit(position, displacement)
	
	var prev_head = head_pos
	var first = true
	
	for section: WormSection in parts.get_children():
		var temp = section.position
		if first:
			section.position = prev_head
			first = false
		elif section.position.distance_to(prev_head) > section.distance:
			var angle = temp.angle_to_point(prev_head)
			section.position = temp + Vector2.from_angle(angle) * dist
		
		prev_head = temp
