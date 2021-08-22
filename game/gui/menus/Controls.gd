extends Node

export(String, FILE, "*.tscn") var main_menu = ""

func _on_Return_pressed() -> void:
# warning-ignore:return_value_discarded
	GameMusic.play_button()
	get_tree().change_scene(main_menu)
