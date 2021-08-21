class_name Player
extends KinematicBody2D


## EXPORTS
export var velocity:Vector2 = Vector2.ZERO
export var start_processing:bool = false

## VARS
var move_direction:int = 1 setget set_move_direction, get_move_direction
export var level_scale:float = 1.0 setget set_level_scale

## ONREADY
onready var animation:AnimatedSprite = $AnimatedSprite
onready var wall_cooldown:Timer = $WallTouchCoolDown

## SETTERS Y GETTERS
func set_level_scale(value: float) -> void:
	level_scale = value

func set_move_direction(value: int) -> void:
	move_direction = value

func get_move_direction() -> int:
	return move_direction

## FUNCS
func _ready() -> void:
	animation.play("idle")
	animation.speed_scale = level_scale
	velocity *= level_scale
	set_physics_process(start_processing)


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	var movement = velocity
	movement.x *= move_direction
	animation.scale.x = move_direction
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector2.UP)
	
	if is_on_floor():
		animation.play("running")
		movement.y = 0.0
	else:
		animation.play("airing")
		movement.x = 0.0
	
	if is_on_wall() and wall_cooldown.time_left == 0.0:
		change_direction()
		wall_cooldown.start()
		
	print(wall_cooldown.time_left)

func set_can_process(value: bool) -> void:
	set_process(value)
	set_physics_process(value)

func change_direction() -> void:
	move_direction *= -1
	Events.emit_signal("player_change_direction")
