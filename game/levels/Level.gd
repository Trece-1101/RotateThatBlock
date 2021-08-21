extends Node

export var explosion:PackedScene = null
export(String, FILE, "*.tscn") var next_level = ""

onready var player:Player = $Player
onready var camera:CameraLevel = $CameraLevel

func _ready() -> void:
	Engine.time_scale = 1.0
	if next_level == "":
		next_level = "res://game/levels/LevelOne.tscn"
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("change_level", self, "_on_change_level")
	camera.set_follow_target(player)
	camera.set_level_text(self.name)

func _on_player_died(player_position: Vector2) -> void:
	if explosion:
		var new_explosion:SimpleExplosion = explosion.instance()
		new_explosion.global_position = player_position
		add_child(new_explosion)

func _on_change_level() -> void:
	get_tree().change_scene(next_level)
