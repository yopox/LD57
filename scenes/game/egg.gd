extends Sprite2D

@onready var timer: Timer = $Timer
@onready var sensors: Sensors = $Sensors
@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var bubble_1: Bubble = $"../Ant/Bubble"
@onready var bubble_2: Bubble = $"../Ant2/Bubble"
@onready var ant_3: Worm = $"../Ant3"

var state: State = State.IDLE
var hp: int = 5

enum State {
	IDLE,
	BREAKING,
	BROKE,
}


func _on_sensors_sensor_enabled(enabled: bool) -> void:
	if state == State.BROKE: return
	if enabled:
		timer.start()
	else:
		timer.stop()


func _on_timer_timeout() -> void:
	hp -= 1
	print(hp)
	if hp == 0:
		particles.amount = 64
		state = State.BROKE
		sensors.active = false
		timer.stop()
		Util.quests.complete_quest(Quests.Name.ANT)
		bubble_1.type = Bubble.Type.HAPPY
		bubble_2.type = Bubble.Type.HAPPY
		particles.emitting = true
		await particles.finished
		visible = false
		ant_3.visible = true
	else:
		particles.emitting = true
