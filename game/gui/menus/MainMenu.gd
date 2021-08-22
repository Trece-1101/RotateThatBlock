extends Control

export(String, FILE, "*.tscn") var level_selection_menu = ""
export(String, FILE, "*.tscn") var credits_menu = ""
export(String, FILE, "*.tscn") var controls_menu = ""


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$LevelBlock.set_can_rotate(true)
	if GameMusic.get_music_playing() != "menu":
		GameMusic.play_music("menu")

func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_Play_pressed() -> void:
	GameMusic.play_button()
	get_tree().change_scene(level_selection_menu)


func _on_Credits_pressed() -> void:
	GameMusic.play_button()
	get_tree().change_scene(credits_menu)


func _on_Controls_pressed() -> void:
	GameMusic.play_button()
	get_tree().change_scene(controls_menu)
