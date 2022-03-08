extends KinematicBody2D
class_name Ship

var speed : float = 300.0
var direction : Vector2

signal spawn_projectile(pos, rot)

func _physics_process(delta: float) -> void:
	move_and_slide(direction * speed)
	
	var mouse_pos = get_global_mouse_position()
	
	var angle = global_position.angle_to_point(mouse_pos) - deg2rad(90.0)
	set_rotation(lerp_angle(rotation, angle, 0.1))



func _input(event: InputEvent) -> void:
	direction = Vector2(Input.get_axis("move_left", "move_right"),
						Input.get_axis("move_up", "move_down"))



func destroy() -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	if Input.is_action_pressed("action"):
		emit_signal("spawn_projectile", global_position, rotation)
