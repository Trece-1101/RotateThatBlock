extends Node2D

export var rotation_time:float = 1.0

var can_rotate = true

onready var tween_rotation:Tween = $TweenRotation

func _ready() -> void:
	$ButtonRotate.set_as_toplevel(true)
	$ButtonRotate.rect_global_position = global_position + Vector2(-560.0, -560.0)


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


func _on_ButtonAntiClockWise_gui_input(event: InputEvent) -> void:
	if event.is_pressed() and can_rotate:
		if event.button_index == BUTTON_LEFT:
			smooth_rotation(-90.0)
			Events.emit_signal("block_rotated", -1)
		elif event.button_index == BUTTON_RIGHT:
			smooth_rotation(90.0)
			Events.emit_signal("block_rotated", 1)
