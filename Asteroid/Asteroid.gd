extends KinematicBody2D
class_name Asteroid

export var speed : float = 100.0
var direction := Vector2.RIGHT


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	
	if collision != null:
		if collision.collider is Ship:
			collision.collider.destroy()


func destroy():
	queue_free()
