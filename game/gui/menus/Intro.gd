extends Node

export(String, FILE, "*.tscn") var main_menu = ""

func change_scene() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(main_menu)
