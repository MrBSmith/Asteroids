extends Node2D

onready var ship = get_node("Ship")

var screen_size = Vector2(ProjectSettings.get_setting("display/window/size/width"), 
						ProjectSettings.get_setting("display/window/size/height"))


var object_dict = {
	"projectile": preload("res://Ship/Projectile/Projectile.tscn"),
	"asteroid": preload("res://Asteroid/Asteroid.tscn")
}


func _spawn_object(obj_name: String, pos: Vector2, rot: float) -> void:
	var obj = object_dict[obj_name].instance()
	rot += deg2rad(90.0)
	obj.rotation = rot
	
	rot -= deg2rad(180.0)
	obj.position = pos
	obj.direction = Vector2(cos(rot), sin(rot))
	add_child(obj)



func _on_Ship_spawn_projectile(pos: Vector2, rot: float) -> void:
	_spawn_object("projectile", pos, rot)


func _on_SpawnAsteroidTimer_timeout() -> void:
	if !is_instance_valid(ship):
		return
	
	var rdm_bool = bool(randi() % 2)
	
	var x = rand_range(0, screen_size.x) if rdm_bool == true else 0.0
	var y = rand_range(0, screen_size.y) if rdm_bool == false else 0.0
	var pos = Vector2(x, y)
	var rot_offset = deg2rad(rand_range(-10.0, 10.0))
	var rot = pos.angle_to_point(ship.global_position) - deg2rad(90.0) + rot_offset
	
	_spawn_object("asteroid", pos, rot)
