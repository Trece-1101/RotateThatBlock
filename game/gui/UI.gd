extends CanvasLayer


func set_level_text(level_name: String) -> void:
	$LevelName.text = level_name

func _on_BtnRetry_pressed() -> void:
#	GameMusic.play_button()
	get_tree().reload_current_scene()


func _on_BtnMenu_pressed() -> void:
#	GameMusic.play_button()
	get_tree().change_scene("res://GUI/Menus/MainMenu.tscn")


func _on_BtnSelection_pressed() -> void:
#	GameMusic.play_button()
	get_tree().change_scene("res://GUI/Menus/LevelSelection.tscn")
