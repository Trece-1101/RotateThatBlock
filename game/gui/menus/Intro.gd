extends Node


func change_scene() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GUI/Menus/MainMenu.tscn")
