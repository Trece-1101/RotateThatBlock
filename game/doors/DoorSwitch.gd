extends Node2D

export var is_closed:bool = true

func _ready() -> void:
	if is_closed:
		$AnimationPlayer.play("default_close")
	else:
		$AnimationPlayer.play("default_open")

func _on_SwitchDetector_body_entered(body: Node) -> void:
	if body.get_move_direction() == 1:
		$AnimationPlayer.play("activate_right")
	else:
		$AnimationPlayer.play("activate_left")
	
	$SwitchDetector/CollisionShape2D.set_deferred("disabled", true)



func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activate_right" or anim_name == "activate_left":
		if is_closed:
			$AnimationPlayer.play("open_door")
		else:
			$AnimationPlayer.play("close_door")
