class_name Quests extends Node


var following_caterpillar: Node2D = null
var saved_caterpillars: int = 0 : set = _set_saved_caterpillars
@export var waiting_caterpillar: Caterpillar

var helped: Dictionary[Name, Variant] = {}

enum Name {
	ANT,
	BIRD,
	MOLE,
	FIREFLY,
	CATERPILLARS,
	WORM,
}


func complete_quest(name: Name) -> void:
	helped[name] = 1


func is_completed(name: Name) -> bool:
	return helped.has(name)


func _ready() -> void:
	Util.quests = self


func _set_saved_caterpillars(value: int) -> void:
	saved_caterpillars = value
	if value != 2: return
	
	waiting_caterpillar.bubble.type = Bubble.Type.HAPPY
	complete_quest(Name.CATERPILLARS)
