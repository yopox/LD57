extends Sprite2D

@onready var quests: Quests = $"../../Quests"
@onready var mole: Mole = $"../Mole"
@onready var player: Worm = $"../../Player"
@onready var bird_bubble: Bubble = $"../../1;0/Bird/Bubble"
@onready var bird_glasses: Node2D = $"../../1;0/Bird + Glasses"
@onready var bird_2: Sprite2D = $"../../1;0/Bird + Glasses/Bird2"



var state: State = State.IDLE

enum State {
	IDLE,
	FOLLOW_PLAYER,
	END,
}


func _process(delta: float) -> void:
	if state != State.FOLLOW_PLAYER: return
	
	if global_position.y < 40 and global_position.x > 312:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "global_position", Vector2(341, 21), 0.75)
		state = State.END
		quests.complete_quest(Quests.Name.BIRD)
		bird_bubble.type = Bubble.Type.HAPPY
		
		Util.block_mov = true
		await tween.finished
		Util.block_mov = false
		
		var tween2 = create_tween()
		tween2.set_trans(Tween.TRANS_CUBIC)
		tween2.tween_property(bird_glasses, "position", Vector2(12, 17), 1.25)
		await tween2.finished
		
		var tween3 = create_tween()
		tween3.set_trans(Tween.TRANS_CUBIC)
		tween3.tween_property(bird_2, "position", Vector2(0, -48), 1.00)
		return
	
	var followed = player.parts.get_children()[-1].global_position
	var pos = global_position
	if pos.distance_to(followed) > 9.0:
		global_position = pos + Vector2.from_angle(pos.angle_to_point(followed))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if state == State.IDLE and mole.state == Mole.State.SLEEPING:
		mole.state = Mole.State.SAD
		state = State.FOLLOW_PLAYER
		var target_pos = player.parts.get_children()[-1].global_position
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "global_position", target_pos, 0.75)
		
		Util.block_mov = true
		await tween.finished
		Util.block_mov = false
		
