extends KinematicBody2D
class_name Projectile

export var speed : float = 800.0
var direction := Vector2.RIGHT


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	
	if collision != null:
		var asteroid = collision.collider
		asteroid.destroy()
