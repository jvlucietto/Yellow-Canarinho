extends CharacterBody2D
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 80;

var direction = 0;

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta;
	
	if(ray_right.is_colliding()):
		direction = 1;
		animated_sprite_2d.flip_h = true;
		animated_sprite_2d.play("slithering")
	
	elif(ray_left.is_colliding()):
		direction = -1;
		animated_sprite_2d.flip_h = false;
		animated_sprite_2d.play("slithering")
	else:
		animated_sprite_2d.flip_h = false;
		direction = 0;
		animated_sprite_2d.play("idle")
		

		
	move_and_slide();
		
		
	position.x += direction * SPEED * delta
	
