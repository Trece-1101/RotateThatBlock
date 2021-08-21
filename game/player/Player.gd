class_name Player
extends KinematicBody2D


## EXPORTS
export var velocity:Vector2 = Vector2.ZERO
export var start_processing:bool = false

## VARS
var move_direction:int = 1 setget set_move_direction, get_move_direction

## ONREADY
onready var animation:AnimatedSprite = $AnimatedSprite

## SETTERS Y GETTERS
func set_move_direction(value: int) -> void:
	move_direction = value

func get_move_direction() -> int:
	return move_direction

## FUNCS
func _ready() -> void:
	animation.play("idle")
	set_physics_process(start_processing)


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	var movement = velocity
	movement.x *= move_direction
	animation.scale.x = move_direction
	move_and_slide(movement, Vector2.UP)
	
	if is_on_floor():
		animation.play("running")
		movement.y = 0.0
	else:
		animation.play("airing")
		movement.x = 0.0
		
# warning-ignore:return_value_discarded

func set_can_process(value: bool) -> void:
	set_process(value)
	set_physics_process(value)

func change_direction() -> void:
	move_direction *= -1
