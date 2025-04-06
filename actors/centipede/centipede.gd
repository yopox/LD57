extends Worm

enum State {
	CIRCLE,
	FOLLOWING,
}

var t: float = 0.0


func _ready() -> void:
	speed = 0.1

func _process(delta: float) -> void:
	move(Vector2.from_angle(t))
	t += delta
