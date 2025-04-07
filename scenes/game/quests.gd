class_name Quests extends Node


var following_caterpillar: Node2D = null
var saved_caterpillars: int = 0 : set = _set_saved_caterpillars
@export var waiting_caterpillar: Caterpillar

var ant_helped: bool = false
var bird_helped: bool = false
var mole_helped: bool = false
var firefly_helped: bool = false
var caterpillars_helped: bool = false
var worm_helped: bool = false


func _ready() -> void:
	Util.quests = self


func _set_saved_caterpillars(value: int) -> void:
	saved_caterpillars = value
	if value != 2: return
	
	waiting_caterpillar.bubble.type = Bubble.Type.HAPPY
	caterpillars_helped = true
