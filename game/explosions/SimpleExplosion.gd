class_name SimpleExplosion
extends Node2D

func _ready() -> void:
	$AnimatedSprite.play("explosion")

func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()
	get_tree().reload_current_scene()
