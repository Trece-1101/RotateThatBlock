extends Area2D



func _on_body_entered(body: Node) -> void:
	var center_offset:Vector2 = global_position
	center_offset.y += 40.0
	body.go_to_portal(center_offset)
