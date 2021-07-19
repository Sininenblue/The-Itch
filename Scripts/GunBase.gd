class_name GunBase
extends Node2D

var drag_speed : float = .4

var input
var mouse_position

onready var hand = self
onready var sprite = $Sprite


func _ready():
	pass


func _input(event):
	if event.is_action_pressed("shoot"):
		pass


func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	
	hand.look_at(mouse_position)
	sprite = lerp_angle(sprite.rotation, get_angle_to(mouse_position), drag_speed)
