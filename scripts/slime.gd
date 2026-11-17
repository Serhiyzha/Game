extends Node2D

const speed = 80

var direction = 1

@onready var ray_cast: RayCast2D = $RayCast
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray_cast: RayCast2D = $WallRayCast

func _process(delta: float) -> void:
	if not ray_cast.is_colliding() or wall_ray_cast.is_colliding():
		direction *= -1 
		ray_cast.position.x *= -1
		wall_ray_cast.target_position.x *= -1
	
	animated_sprite.flip_h = direction < 0 
	
	position.x += direction * speed * delta
