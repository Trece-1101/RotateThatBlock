extends Node

export var explosion:PackedScene = null
export(String, FILE, "*.tscn") var next_level = ""

onready var player:Player = $Player
onready var camera:CameraLevel = $CameraLevel

func _ready() -> void:
	if GameMusic.get_music_playing() != "level":
		GameMusic.play_music("level")
	
	Engine.time_scale = 1.0
	
	if next_level == "":
		next_level = "res://game/levels/LevelOne.tscn"
	
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("change_level", self, "_on_change_level")
	camera.set_follow_target(player)
	camera.set_level_text(self.name)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()
	elif event.is_action_pressed("main"):
		get_tree().change_scene("res://game/gui/menus/MainMenu.tscn")
	elif event.is_action_pressed("level_selection"):
		get_tree().change_scene("res://game/gui/menus/LevelSelection.tscn")

func _on_player_died(player_position: Vector2) -> void:
	if explosion:
		var new_explosion:SimpleExplosion = explosion.instance()
		new_explosion.global_position = player_position
		add_child(new_explosion)

func _on_change_level() -> void:
	GameData.new_unlock_level()
	get_tree().change_scene(next_level)
