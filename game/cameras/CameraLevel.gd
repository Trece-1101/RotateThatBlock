class_name CameraLevel
extends Camera2D

## EXPORTS
export var target_offset_h:float = 500.0
export var target_offset_v:float = 100.0

## VARS
var follow_target:Node2D setget set_follow_target
var level_text:String setget set_level_text
var wait_time:int = 3

## ONREADYS
onready var transition_h:Tween = $TweenTransitionH
onready var transition_v:Tween = $TweenTransitionV

## SETTERS Y GETTERS
func set_follow_target(value: Node2D) -> void:
	follow_target = value

func set_level_text(value: String) -> void:
	level_text = value
	$UI.set_level_text(level_text)

## FUNCS
func _ready() -> void:
	Events.connect("player_change_direction", self, "_on_player_change_direction")
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("player_in_portal", self, "_on_player_in_portal")
	Events.connect("see_below", self, "_on_see_below")
	update_time_label()
	$AnimationPlayer.play("fade_out")

func _process(_delta: float) -> void:
	if not follow_target:
		return
	
	position.x = follow_target.position.x + target_offset_h
	position.y = follow_target.position.y + target_offset_v

func _on_player_change_direction() -> void:
	transition_h.interpolate_property(
		self,
		"target_offset_h",
		target_offset_h,
		target_offset_h * -1,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	transition_h.start()

func _on_see_below() -> void:
	transition_v.interpolate_property(
		self,
		"target_offset_v",
		target_offset_v,
		-target_offset_v,
		0.4,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	transition_v.start()

func _on_player_died(_player_position: Vector2) -> void:
	follow_target = null

func update_time_label() -> void:
	wait_time -= 1
	if wait_time == 0:
		$LabelTime.text = "GO!!"
		$Timer.stop()
		$Timer.queue_free()
		yield(get_tree().create_timer(0.2),"timeout")
		$LabelTime.queue_free()
		Events.emit_signal("player_ready")
	else:
		$LabelTime.text = str(wait_time) + "..."

func _on_player_in_portal() -> void:
	$AnimationPlayer.play("fade_in")

func _on_Timer_timeout() -> void:
	update_time_label()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		Events.emit_signal("change_level")
