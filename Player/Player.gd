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

var should_dash : bool = false

onready var timer_dash_duration = $TimerDashDuration
onready var timer_dash_cooldown = $TimerDashCooldown

func _ready():
	pass


func _input(event):
	if event.is_action_pressed("dash") and timer_dash_cooldown.is_stopped():
		should_dash = true
	else:
		should_dash = false


func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
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
