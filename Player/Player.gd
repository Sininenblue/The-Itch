extends KinematicBody2D

var speed : float = 150.0
var accel : float = 50.0
var dash : float = 400.0
var dash_accel : float = 80.0
var friction : float = 10.0

var velocity : Vector2
var input : Vector2
var direction : Vector2
var mouse_position : Vector2
var interacting

var should_dash : bool = false

onready var timer_dash_duration = $TimerDashDuration
onready var timer_dash_cooldown = $TimerDashCooldown


func _input(event):
	if event.is_action_pressed("dash") and timer_dash_cooldown.is_stopped():
		should_dash = true
	else:
		should_dash = false


func _physics_process(delta):
	interacting = Input.is_action_just_pressed("interact")
	
	mouse_position = get_global_mouse_position()
	
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input = input.normalized()

# states 
func state_idle():
	velocity = velocity.move_toward(Vector2.ZERO, friction)


func state_move():
	velocity = velocity.move_toward(input * speed, accel)


func enter_state_dash():
	timer_dash_duration.start()
	timer_dash_cooldown.start()

func state_dash():
	velocity = velocity.move_toward(direction * dash, dash_accel)


func _apply_velocity():
	velocity = move_and_slide(velocity)
