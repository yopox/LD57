extends Sprite2D

@onready var player: Node2D = $"../../../Player"
@onready var mole: Mole = $"../../../1;2/Mole"


var state: State = State.IDLE

enum State {
	IDLE,
	FOLLOW_PLAYER,
	END,
}

func _process(delta: float) -> void:
	if state != State.FOLLOW_PLAYER: return

	var followed = player.parts.get_children()[-1].global_position
	var pos = global_position
	if pos.distance_to(followed) > 9.0:
		global_position = pos + Vector2.from_angle(pos.angle_to_point(followed))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if state == State.IDLE:
		state = State.FOLLOW_PLAYER
		var target_pos = player.parts.get_children()[-1].global_position
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "global_position", target_pos, 0.75)
		
		Util.block_mov = true
		await tween.finished
		Util.block_mov = false
		
	if state == State.FOLLOW_PLAYER and area.collision_layer == 16:
		state = State.END
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "global_position", Vector2(208, 271), 0.75)
		
		Util.block_mov = true
		await tween.finished
		Util.block_mov = false
		
		mole.bubble.type = Bubble.Type.HAPPY
		mole.frame = 0
		Util.quests.complete_quest(Quests.Name.MOLE)
