extends Node2D

@onready var version: Label = $Footer/version


func _ready() -> void:
	version.text = "v" + ProjectSettings.get_setting("application/config/version")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("w") or\
		Input.is_action_just_pressed("e") or\
		Input.is_action_just_pressed("d") or\
		Input.is_action_just_pressed("x") or\
		Input.is_action_just_pressed("z") or\
		Input.is_action_just_pressed("a"):
		Util.scene_manager.change_2d_scene(Util.Scenes.Game)
