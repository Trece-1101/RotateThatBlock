extends Node

onready var player:Player = $Player
onready var camera:CameraLevel = $CameraLevel

func _ready() -> void:
	camera.set_follow_target(player)


