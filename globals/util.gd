extends Node

enum Scenes { Game }

var scene_manager: SceneManager
var quests: Quests
var player: Worm
var block_mov: bool = false

var scene_paths: Dictionary[Scenes, String] = {
	Scenes.Game: "res://scenes/game/game.tscn",
}
