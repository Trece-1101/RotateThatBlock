extends Node2D

export var rotation_time:float = 1.0

var can_rotate = false

onready var tween_rotation:Tween = $TweenRotation

func _ready() -> void:
	$ButtonRotate.set_as_toplevel(true)
	$ButtonRotate.rect_global_position = global_position + Vector2(-453.0, -453.0)
	$SeeBelowButton.set_as_toplevel(true)
	$SeeBelowButton.rect_global_position = global_position + Vector2(-560.0, 455.0)
	Events.connect("player_ready", self, "_on_player_ready")

func _on_player_ready() -> void:
	can_rotate = true

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
	if event.is_action_pressed("acelerate"):
		if Engine.time_scale < 4.0:
			Engine.time_scale += 0.5
		return
	elif event.is_action_pressed("deacelerate"):
		Engine.time_scale = 1.0
		return
	
	if event is InputEventMouseButton and event.is_pressed() and can_rotate:
		if event.button_index == BUTTON_LEFT:
			smooth_rotation(-90.0)
			Events.emit_signal("block_rotated", -1)
		elif event.button_index == BUTTON_RIGHT:
			smooth_rotation(90.0)
			Events.emit_signal("block_rotated", 1)
		else:
			return


func _on_SeeBelowButton_mouse_entered() -> void:
	Events.emit_signal("see_below")
