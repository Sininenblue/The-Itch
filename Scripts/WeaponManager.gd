extends Node2D

var player
var player_interacting : bool = false
var weapons = []


func _ready():
	weapons.append(preload("res://Guns/Rifle.tscn"))




func set_weapon(weapon_name):
	for weapon in weapons:
		if weapon_name in weapon.instance().name:
			var weapon_to_instance = weapon.instance() 
			weapon_to_instance.active = true
			player.add_child(weapon_to_instance)
