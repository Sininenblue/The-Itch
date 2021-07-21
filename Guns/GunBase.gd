extends Node2D
# A base node for all guns

export(int, "bullet", "arrow", "shell") var ammo_type
export var damage : int = 1
export var speed : float = 200.0
export var ammo_max : int = 20

var ammo_current : int = ammo_max
var shooting : bool = false
var active : bool = false
var holder

onready var sprite = $Sprite
onready var muzzle = $Muzzle
onready var timer_fire_rate = $TimerFireRate
onready var timer_drop_buffer = $TimerDropBuffer
onready var grab_range = $GrabRange
onready var grab_range_collision = $GrabRange/CollisionShape2D

onready var BULLET = preload("res://Guns/Ammo/Bullet.tscn")


func _ready():
	pass


func _process(delta):
	if holder != null:
		
		if active:
			if holder.interacting and timer_drop_buffer.is_stopped():
				active = false
			
			position = holder.position
			shooting = Input.is_action_pressed("shoot")
			look_at(get_global_mouse_position())
			
			if shooting and timer_fire_rate.is_stopped():
				timer_fire_rate.start()
				shoot()
		else:
			if holder.interacting:
				timer_drop_buffer.start()
				active = true


func shoot():
	match ammo_type:
		0:
			instance_ammo(BULLET)
		1:
			print(ammo_type)
		2:
			print(ammo_type)


func instance_ammo(ammo_type_to_instance):
	var to_instance = ammo_type_to_instance.instance()
	to_instance.speed = speed
	to_instance.rotation = rotation
	to_instance.position = muzzle.global_position # something wrong with this
	get_parent().add_child(to_instance)


func _on_GrabRange_body_entered(body):
	holder = body


func _on_GrabRange_body_exited(body):
	holder = null
