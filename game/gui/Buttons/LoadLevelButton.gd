extends Button

export var level_to_load := ""
onready var level_assigned: int setget ,get_level_assigned

func get_level_assigned() -> int:
	return level_assigned

func _ready() -> void:
	level_assigned = text as int

func get_level_to_load() -> String:
	if level_to_load == "":
		return name
	
	return level_to_load
