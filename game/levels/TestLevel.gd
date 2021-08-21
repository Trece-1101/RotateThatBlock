extends Node

export var explosion:PackedScene = null

onready var player:Player = $Player
onready var camera:CameraLevel = $CameraLevel

func _ready() -> void:
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("player_in_portal", self, "_on_player_in_portal")
	camera.set_follow_target(player)


func _on_player_died(player_position: Vector2) -> void:
	if explosion:
		var new_explosion:SimpleExplosion = explosion.instance()
		new_explosion.global_position = player_position
		add_child(new_explosion)

func _on_player_in_portal() -> void:
	pass
