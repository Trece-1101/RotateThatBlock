extends Area2D

onready var sprite:Sprite = $Sprite

func _process(delta: float) -> void:
	sprite.rotate(rad2deg(1 * delta))


func _on_body_entered(body: Node) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	body.die()
