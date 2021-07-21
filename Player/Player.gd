extends KinematicBody2D

var speed : float = 150.0
var accel : float = 50.0
var dash : float = 400.0
var dash_accel : float = 80.0
var friction : float = 10.0

var weapon_on_hand setget set_weapon
var velocity : Vector2
var input : Vector2
var direction : Vector2
var mouse_position : Vector2

var should_dash : bool = false

onready var timer_dash_duration = $TimerDashDuration
onready var timer_dash_cooldown = $TimerDashCooldown
onready var grab_range_collision = $GrabRange/CollisionShape2D
onready var weapon_manager = $WeaponManager


func _ready():
	pass


func _input(event):
	if event.is_action_pressed("dash") and timer_dash_cooldown.is_stopped():
		should_dash = true
	else:
		should_dash = false
	
	if event.is_action_pressed("pick_up"):
		grab_range_collision.disabled = false
	else:
		grab_range_collision.disabled = true


func _physics_process(delta):
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


func _on_GrabRange_area_entered(area):
	if area.is_in_group("weapon"):
		
		if weapon_on_hand == null:
			self.weapon_on_hand = area.get_parent().name
			area.get_parent().call_deferred("queue_free")
		else:
			for child in get_children():
				if weapon_on_hand == child.name:
					child.on_ground = false
					child.call_deferred("queue_free")
			
			self.weapon_on_hand = area.get_parent().name
			area.get_parent().call_deferred("queue_free")


func set_weapon(weapon_name):
	if weapon_on_hand != null:
		for weapon in weapon_manager.weapons:
			if weapon.instance().name == weapon_on_hand:
				weapon_manager.throw_weapon(weapon_on_hand)
	
	weapon_on_hand = weapon_name
	
	for weapon in weapon_manager.weapons:
		if weapon.instance().name == weapon_on_hand:
			weapon_manager.get_weapon(weapon_on_hand)
