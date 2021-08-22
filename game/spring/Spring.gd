extends Node2D



func _on_PlayerDetector_body_entered(body: Node) -> void:
	$AnimationPlayer.play("spring")
	$PlayerDetector/CollisionShape2D.set_deferred("disabled", true)
	body.impulse()
	$AudioStreamPlayer2D.play()
