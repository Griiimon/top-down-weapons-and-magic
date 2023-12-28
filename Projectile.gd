extends Node2D
class_name Projectile

var speed: float

func _physics_process(delta):
	global_position+= -global_transform.y * speed
