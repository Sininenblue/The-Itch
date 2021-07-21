extends Area2D

var damage : int
var speed : float = 400.0

var velocity = Vector2.ZERO

func start(_transform):
	global_transform = _transform
	velocity = transform.x * speed


func _ready():
	velocity = velocity.rotated(rotation)


func _physics_process(delta):
	position += velocity * speed * delta
