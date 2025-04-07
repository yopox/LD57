class_name Sensors extends Node

signal sensor_enabled(enabled: bool)


var active = true
var enabled = false


func _process(delta: float) -> void:
	if !active: return
	for area in get_children():
		if !area is Area2D: continue
		if (area as Area2D).get_overlapping_areas().size() == 0:
			if enabled:
				enabled = false
				sensor_enabled.emit(false)
			return
	
	if !enabled:
		enabled = true
		sensor_enabled.emit(true)
