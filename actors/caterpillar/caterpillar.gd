class_name Caterpillar extends Worm

enum State {
	CIRCLE,
	FOLLOWING,
	GO_BACK,
	ARRIVED,
	HAPPY,
	WAITING,
}

@export var state: State
@export var bubble: Bubble
@export var target_dest: Node2D

var start_pos: Vector2
var t: float = 0.0


func _ready() -> void:
	start_pos = global_position


func _process(delta: float) -> void:
	match state:
		State.HAPPY:
			move(Vector2.from_angle(t))
		State.WAITING:
			move(Vector2.from_angle(t))
		State.CIRCLE:
			move(Vector2.from_angle(t))
			detect_player()
		State.FOLLOWING:
			follow_player()
		State.GO_BACK:
			go_to_start_dest()
		State.ARRIVED:
			go_to_target_dest()
	t += delta


func detect_player() -> void:
	if Util.quests.following_caterpillar != null: return
	var tracked_pos: Vector2 = Util.player.global_position
	if global_position.distance_to(tracked_pos) < 16.0:
		state = State.FOLLOWING
		Util.quests.following_caterpillar = self
		bubble.type = Bubble.Type.SHOCKED


func follow_player() -> void:
	var tracked: Node2D = Util.player.parts.get_children()[-1]
	var tracked_pos: Vector2 = tracked.global_position
	var dist = tracked_pos.distance_to(global_position)
	if dist > 8.0 and dist < 32.0:
		move(Vector2.from_angle(global_position.angle_to_point(tracked_pos)))
	elif dist > 40.0:
		state = State.GO_BACK
		bubble.type = Bubble.Type.SAD
		Util.quests.following_caterpillar = null


func go_to_target_dest() -> void:
	var dest = target_dest.global_position
	var dist = dest.distance_to(global_position)
	if dist > 0.1:
		move(Vector2.from_angle(global_position.angle_to_point(dest)))
	else:
		t = 0
		state = State.HAPPY
		bubble.type = Bubble.Type.HAPPY


func go_to_start_dest() -> void:
	var dist = start_pos.distance_to(global_position)
	if dist > 0.1:
		move(Vector2.from_angle(global_position.angle_to_point(start_pos)))
	else:
		t = 0
		state = State.CIRCLE

func _on_camera_2d_quadrant_changed(quadrant: Vector2i) -> void:
	if state != State.FOLLOWING: return
	if quadrant.x != 1 or quadrant.y != 1: return
	state = State.ARRIVED
	Util.quests.saved_caterpillars += 1
	Util.quests.following_caterpillar = null
