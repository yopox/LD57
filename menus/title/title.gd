extends Node2D

@onready var version: Label = $Footer/version
@onready var y_menu: YMenu = $YMenu


func _ready() -> void:
	version.text = "version " + ProjectSettings.get_setting("application/config/version")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("a") or Input.is_action_just_pressed("start"):
		match y_menu.selected_item:
			0: Util.scene_manager.change_2d_scene(Util.Scenes.Game)
			1: get_tree().quit()
