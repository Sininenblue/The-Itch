extends Node2D


export(int, "bullet", "arrow", "cannon") var ammo_type
export var damage : int = 1
export var speed : float = 200.0
export var ammo_max : int = 20

var ammo_current : int = ammo_max
var shooting : bool = false

onready var sprite = $Sprite
onready var timer_fire_rate = $TimerFireRate


func _ready():
	pass


func _process(delta):
	shooting = Input.is_action_pressed("shoot")
	
	if shooting and timer_fire_rate.is_stopped():
		timer_fire_rate.start()
		print('shoot')
