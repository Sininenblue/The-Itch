class_name GunBase
extends Node2D
# the base script for all guns
# includes inputs, rotation, sprite thing
# does not include what bullet to shoot and fire rate and stuff

var BULLET = preload("res://Guns/Bullet/Bullet.tscn")

export var drag_speed : float = .4
export var ammo_max : int = 20
export var ammo_current : int = 20 setget set_ammo

var on_ground : bool = true setget set_on_ground
var can_shoot : bool = true
var mouse_position : Vector2
var shooting : bool

onready var hand = self
onready var sprite = $Sprite
onready var timer_fire_rate = $TimerFireRate
onready var timer_reload = $TimerReload


func _ready():
	$Collision.add_to_group("weapon")
	timer_reload.connect("timeout", self, "_on_TimerReload_timeout")


func _input(event):
	pass


func _physics_process(delta):
	if Input.is_action_pressed("shoot"):
		shooting = true
	else:
		shooting = false
	
	if !on_ground:
		mouse_position = get_global_mouse_position()
		hand.look_at(mouse_position)
		sprite.rotation = lerp_angle(sprite.rotation, get_angle_to(mouse_position), drag_speed)


func _on_TimerReload_timeout():
	can_shoot = true
	self.ammo_current = ammo_max


func shoot(damage, speed):
	self.ammo_current -= 1
	timer_fire_rate.start()
	
	var bullet = BULLET.instance()
	
	bullet.damage = damage
	bullet.speed = speed
	
	get_parent().get_parent().add_child(bullet)


func set_ammo(new_value):
	ammo_current = new_value
	
	if ammo_current <= 0:
		timer_reload.start()
		can_shoot = false

func set_on_ground(new_value):
	on_ground = new_value
	
	if on_ground == false:
		$Collision/CollisionShape2D.set_deferred("disabled", true)
	else:
		$Collision/CollisionShape2D.set_deferred("disabled", false)
