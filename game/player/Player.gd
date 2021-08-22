class_name Player
extends KinematicBody2D


## EXPORTS
export var velocity:Vector2 = Vector2.ZERO
export var start_processing:bool = false

## VARS
var move_direction:int = 1 setget set_move_direction, get_move_direction
var level_scale:float = 1.0 setget set_level_scale
var original_velocity:Vector2 = Vector2.ZERO

## ONREADY
onready var animation:AnimatedSprite = $AnimatedSprite
onready var wall_cooldown:Timer = $WallTouchCoolDown
onready var enter_portal_tween:Tween = $Tween

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
	original_velocity = velocity
	set_physics_process(start_processing)
	Events.connect("block_rotated", self, "_on_block_rotated")
	Events.connect("player_ready", self, "_on_ready")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("acelerate"):
		if Engine.time_scale < 4.0:
			Engine.time_scale += 0.5
		return
	elif event.is_action_pressed("deacelerate"):
		Engine.time_scale = 1.0
		return

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

func _on_ready() -> void:
	set_can_process(true)

func set_can_process(value: bool) -> void:
	set_process(value)
	set_physics_process(value)

func change_direction() -> void:
	move_direction *= -1
	Events.emit_signal("player_change_direction")

func _on_block_rotated(_direction: int) -> void:
	wall_cooldown.stop()
	wall_cooldown.start()
#	if move_direction != direction:
#		move_direction = direction
#		Events.emit_signal("player_change_direction")

func go_to_portal(center: Vector2) -> void:
	velocity = Vector2.ZERO
	enter_portal_tween.interpolate_property(
		self,
		"global_position",
		global_position,
		center,
		1.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	enter_portal_tween.start()
	$AnimationPlayer.play("enter_portal")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "enter_portal":
		Events.emit_signal("player_in_portal")

func impulse() -> void:
	velocity.y = -800
	$ImpulseCoolDown.start()

func die() -> void:
	Events.emit_signal("player_died", global_position)
	queue_free()


func _on_ImpulseCoolDown_timeout() -> void:
	velocity = original_velocity
