class_name Mole extends Sprite2D

var state = State.SLEEPING: set = _set_state
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum State {
	SLEEPING,
	AWAKE,
	SAD,
	HAPPY
}


func _set_state(value: State) -> void:
	state = value
	match state:
		State.SLEEPING:
			animation_player.play("sleeping")
		State.AWAKE:
			animation_player.stop()
			frame = 1
		State.HAPPY:
			animation_player.stop()
			frame = 0


func _on_wake_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if state != State.SLEEPING: return
	state = State.AWAKE


func _on_camera_2d_quadrant_changed(quadrant: Vector2i) -> void:
	if state != State.AWAKE: return
	if quadrant.x == -1 or quadrant.y < 2:
		state = State.SLEEPING
