extends Area2D

export var health_max : int = 4
var health_current : int = health_max setget set_health

onready var parent = get_parent()

func set_health(new_value):
	health_current = new_value
	
	if health_current <= health_max:
		print('dead')
