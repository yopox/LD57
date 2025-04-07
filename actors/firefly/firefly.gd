extends Node2D

@export var mark_node: Node
@export var bubble: Bubble

@onready var sprite: Sprite2D = $Sprite2D

enum State {
	GO_UP,
	SURFACE,
	FLOATING,
}

var state: State = State.GO_UP
var speed: float = 10
var t: float = 0.0
var head_pos: Vector2 = Vector2.ZERO

var dirt = preload("res://actors/worm/dirt.tscn")


func _process(delta: float) -> void:
	sprite.position.x = cos(t * 1.7)
	sprite.position.y = sin(t * 0.9)
	t += delta
	match state:
		State.GO_UP:
			go_up(delta)
			dirt_mark()
		State.SURFACE:
			go_to_air(delta)
			dirt_mark()
		State.FLOATING:
			pass
	


func go_up(delta: float) -> void:
	var m_pos: Variant = null
	var fp = global_position
	for mark_parent in mark_node.get_parent().get_children():
		if m_pos != null: break
		if mark_parent == mark_node: continue
		for mark in mark_parent.get_children():
			var mp = mark.global_position
			if not (mp.y > fp.y - 12 and mp.y < fp.y): continue
			if not (mp.x > fp.x - 6 and mp.x < fp.x + 6): continue
			m_pos = mp
			break
	
	if m_pos == null: return
	move_up(fp.angle_to_point(m_pos), delta)
	
	if global_position.y < 56:
		state = State.SURFACE
		bubble.type = Bubble.Type.SHOCKED


func go_to_air(delta: float) -> void:
	move_up(-PI / 2, delta)
	
	if global_position.y < 24:
		state = State.FLOATING
		bubble.type = Bubble.Type.HAPPY
		Util.quests.complete_quest(Quests.Name.FIREFLY)


func move_up(angle: float, delta: float) -> void:
	var disp = Vector2.from_angle(angle) * speed * delta
	position += disp


func dirt_mark() -> void:
	if global_position.y < 40: return
	
	var dirt_mark: Node2D = dirt.instantiate()
	dirt_mark.position = sprite.global_position
	mark_node.add_child(dirt_mark)
	
	var dirt_marks = mark_node.get_children()
	for i in range(0, dirt_marks.size() - 200):
		dirt_marks[i].queue_free()
