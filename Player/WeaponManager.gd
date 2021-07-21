extends Node2D

var weapons = []
onready var AssultRifle = preload("res://Guns/AssultRifle.tscn")
onready var parent = get_parent()


func _ready():
	weapons.append(AssultRifle)


func get_weapon(weapon_name):
	var weapon_to_instance
	for weapon in weapons:
		if weapon.instance().name == weapon_name:
			weapon_to_instance = weapon
	
	var weapon_to_spawn = weapon_to_instance.instance()
	weapon_to_spawn.on_ground = false
	parent.call_deferred("add_child",weapon_to_spawn)


func throw_weapon(weapon_name):
	var weapon_to_instance
	for weapon in weapons:
		if weapon.instance().name == weapon_name:
			weapon_to_instance = weapon
	
	var weapon_to_throw = weapon_to_instance.instance()
	weapon_to_throw.on_ground = true
	get_parent().get_parent().call_deferred("add_child",weapon_to_throw)
	weapon_to_throw.global_position = global_position
