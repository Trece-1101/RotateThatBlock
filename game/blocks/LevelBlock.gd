extends Node2D

export var rotation_time:float = 1.0

var can_rotate = true

onready var tween_rotation:Tween = $TweenRotation

func _ready() -> void:
	$ButtonAntiClockWise.set_as_toplevel(true)
	$ButtonClockWise.set_as_toplevel(true)
	$ButtonAntiClockWise.rect_global_position = global_position + Vector2(-160.0, -80.0)
	$ButtonClockWise.rect_global_position = global_position + Vector2(8.0, -80.0)

func _on_ButtonAntiClockWise_pressed() -> void:
	smooth_rotation(-90.0)


func _on_ButtonClockWise_pressed() -> void:
	smooth_rotation(90.0)


func smooth_rotation(rot_value: float) -> void:
	if not can_rotate:
		return
	
	can_rotate = false
	
	tween_rotation.interpolate_property(
		self,
		"rotation_degrees",
		rotation_degrees,
		rotation_degrees + rot_value,
		rotation_time,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	tween_rotation.start()


func _on_TweenRotation_tween_all_completed() -> void:
	can_rotate = true
