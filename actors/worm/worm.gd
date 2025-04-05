class_name Worm extends Node2D

@onready var parts: Node2D = $Parts
@onready var color_rect: ColorRect = $ColorRect

var head_pos = Vector2(0.0, 0.0)
var speed = 0.3

func _process(delta: float) -> void:
	move()


func move():
	var moved = false
	
	var dx = Input.get_axis("left", "right")
	var dy = Input.get_axis("up", "down")
	
	if abs(dx) < 0.001 and abs(dy) < 0.001: return
	
	var move = Vector2(dx, dy).normalized() * speed
	var dist = speed
	
	if dist > 0.001:
		head_pos += move
		moved = true

	if moved:
		color_rect.position = head_pos
		var prev_head = head_pos
		var z = Util.Z_WORM + parts.get_children().size()
		for section: WormSection in parts.get_children():
			var temp = section.position
			if section.position.distance_to(prev_head) > 3.0:
				var angle = temp.angle_to_point(prev_head)
				section.position = temp + Vector2.from_angle(angle) * dist
			section.z_index = z
			z -= 1
			prev_head = temp
