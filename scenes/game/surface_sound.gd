extends AudioStreamPlayer

@onready var player: Node2D = $"../Player"

#var lpf: AudioEffectFilter
#
#
#func _ready() -> void:
	#lpf = AudioServer.get_bus_effect(1, 0)

func _process(_delta: float) -> void:
	var y = player.global_position.y
	#lpf.cutoff_hz = max(0, 8000 - y * 60)
	volume_linear = clamp(1 - y / 100, 0, 1)
