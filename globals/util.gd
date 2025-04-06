extends Node

enum Scenes { Title, Game }

var scene_manager: SceneManager

var dirt: Node2D

var scene_paths: Dictionary[Scenes, String] = {
	Scenes.Title: "res://menus/title/title.tscn",
	Scenes.Game: "res://scenes/game/game.tscn",
}
