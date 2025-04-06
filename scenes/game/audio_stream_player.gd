extends AudioStreamPlayer


@onready var player: Node2D = $"../Player"
@onready var firefly: Node2D = $"../-1;1/Firefly"
@onready var ant: Worm = $"../-1;2/anthill/Ant"
@onready var centipede_1: Node2D = $"../-1;0/Centipede"
@onready var centipede_2: Node2D = $"../-1;1/Centipede"
@onready var centipede_3: Node2D = $"../1;1/Centipede"
@onready var worm: Worm = $"../0;1/Worm"
@onready var mole: Sprite2D = $"../1;2/Mole"
@onready var bird: Sprite2D = $"../1;0/Bird"

var streams: AudioStreamSynchronized


func _ready() -> void:
	streams = stream as AudioStreamSynchronized


func set_volume(i: int, db: float):
	streams.set_sync_stream_volume(i, clamp(db, -100, 0))


func _process(_delta: float) -> void:
	var p = player.global_position
	var ratio = 300
	
	set_volume(1, -p.distance_squared_to(firefly.global_position) / ratio)
	set_volume(2, -p.distance_squared_to(ant.global_position) / ratio)
	set_volume(3, -p.distance_squared_to(centipede_1.global_position) / ratio)
	set_volume(4, -p.distance_squared_to(centipede_2.global_position) / ratio)
	set_volume(5, -p.distance_squared_to(centipede_3.global_position) / ratio)
	set_volume(6, -p.distance_squared_to(mole.global_position) / ratio / 2.5)
	set_volume(7, -p.distance_squared_to(mole.global_position) / ratio / 2.5)
	set_volume(8, -p.distance_squared_to(worm.global_position) / ratio * 1.25)
	set_volume(9, -p.distance_squared_to(bird.global_position) / ratio)
