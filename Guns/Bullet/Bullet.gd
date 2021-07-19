extends Node2D


var speed : int
var damage : int


func _ready():
	pass


func _physics_process(delta):
	position.x += speed * delta
