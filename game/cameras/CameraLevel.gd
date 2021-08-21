class_name CameraLevel
extends Camera2D

export var target_offset_h:float = 500.0
export var target_offset_v:float = 100.0

var follow_target:Node2D setget set_follow_target

onready var transition_h:Tween = $TweenTransitionH

func set_follow_target(value: Node2D) -> void:
	follow_target = value

func _ready() -> void:
	Events.connect("player_change_direction", self, "_on_player_change_direction")

func _process(_delta: float) -> void:
	position.x = follow_target.position.x + target_offset_h
	position.y = follow_target.position.y + target_offset_v

func _on_player_change_direction() -> void:
#	target_offset *= 0
	transition_h.interpolate_property(
		self,
		"target_offset_h",
		target_offset_h,
		target_offset_h * -1,
		1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	transition_h.start()
