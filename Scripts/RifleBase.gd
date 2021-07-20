class_name RifleType
extends GunBase

export var damage : int = 1
export var speed : int = 200

func _physics_process(delta):
	if !on_ground:
		if shooting and timer_fire_rate.is_stopped() and can_shoot:
			shoot(damage, speed)
	else:
		pass
