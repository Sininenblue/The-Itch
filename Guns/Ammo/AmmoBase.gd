extends Area2D
# the base node for all ammo types

var damage : int
var speed : float = 400.0

var holder_name : String
var velocity = Vector2.RIGHT


func start(_transform):
	global_transform = _transform
	velocity = transform.x * speed


func _ready():
	velocity = velocity.rotated(rotation)


func _physics_process(delta):
	position += velocity * speed * delta


func _on_AmmoBase_area_entered(area):
	if area.is_in_group("shootable"):
		#so that it doesn't collide with parent
		if !area.get_parent().name in holder_name:
			area.health_current = area.health_current - damage
			call_deferred("queue_free")


func _on_AmmoBase_body_entered(body):
	if body.is_in_group("environment"):
		pass
