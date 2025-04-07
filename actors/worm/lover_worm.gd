extends Worm

@onready var bubble: Bubble = $Bubble
@onready var sensors: Sensors = $"../Sensors"


func _on_sensors_sensor_enabled(enabled: bool) -> void:
	bubble.type = Bubble.Type.HAPPY
	Util.quests.complete_quest(Quests.Name.WORM)
	sensors.active = false
