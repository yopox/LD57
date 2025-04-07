class_name Quests extends Node

@onready var heart_1: Sprite2D = $"../CanvasLayer/Progress/Heart1"
@onready var heart_2: Sprite2D = $"../CanvasLayer/Progress/Heart2"
@onready var heart_3: Sprite2D = $"../CanvasLayer/Progress/Heart3"
@onready var heart_4: Sprite2D = $"../CanvasLayer/Progress/Heart4"
@onready var heart_5: Sprite2D = $"../CanvasLayer/Progress/Heart5"
@onready var heart_6: Sprite2D = $"../CanvasLayer/Progress/Heart6"

@export var waiting_caterpillar: Caterpillar

var following_caterpillar: Node2D = null
var saved_caterpillars: int = 0 : set = _set_saved_caterpillars

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
	match name:
		Name.FIREFLY:
			heart_1.visible = true
		Name.CATERPILLARS:
			heart_2.visible = true
		Name.ANT:
			heart_3.visible = true
		Name.BIRD:
			heart_4.visible = true
		Name.MOLE:
			heart_5.visible = true
		Name.WORM:
			heart_6.visible = true


func is_completed(name: Name) -> bool:
	return helped.has(name)


func _ready() -> void:
	Util.quests = self


func _set_saved_caterpillars(value: int) -> void:
	saved_caterpillars = value
	if value != 2: return
	
	waiting_caterpillar.bubble.type = Bubble.Type.HAPPY
	complete_quest(Name.CATERPILLARS)
