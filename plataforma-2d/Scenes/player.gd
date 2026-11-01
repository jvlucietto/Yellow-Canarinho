extends CharacterBody2D
@onready var label: Label = $Camera2D/Label
@onready var win_screen: Label = $Camera2D/winScreen
@onready var snakes: Node = $"../Snakes"
@onready var jump_sound: AudioStreamPlayer = $jump_sound
@onready var attack_sound: AudioStreamPlayer = $attack_sound


var SPEED = 110.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var air_jump = true;
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var snakesLeft = snakes.get_child_count();


func _physics_process(delta: float) -> void:
	
	label.text = "Cobras restantes: " + str(snakesLeft)
	
	
	
	if snakesLeft <= 0:
		win_screen.visible = true;
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and air_jump:
		velocity.y = JUMP_VELOCITY
		air_jump = false;
		jump_sound.play();
		await  get_tree().create_timer(0.5).timeout;
	
	if is_on_floor():
		air_jump = true;
		
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("go_left", "go_right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Flippa o sprite pela direção 
	if(direction > 0):
		animated_sprite_2d.flip_h = false;
	elif direction < 0:
		animated_sprite_2d.flip_h = true;
	
	#maneja as animações
	if direction == 0 and is_on_floor() :
		animated_sprite_2d.play("idle");
	elif not is_on_floor():
		animated_sprite_2d.play("jumping")
	else:
		animated_sprite_2d.play("running")

		
		
	#floating in the air
	#if Input.is_action_pressed("float_in_the_air") and not is_on_floor():
			#velocity.y = -100;
			#velocity.y = velocity.y + 1;
			#
		#
	
	
	#mata o inimigo ao pular na cabeça dele
	
	if ray_cast_2d.is_colliding():
		var enemy = ray_cast_2d.get_collider()
		if enemy is CharacterBody2D:
			enemy.set_collision_mask_value(1,false);
			velocity.y = JUMP_VELOCITY
			velocity.x = JUMP_VELOCITY * direction
			attack_sound.play();
			await get_tree().create_timer(0.5).timeout
			if is_instance_valid(enemy):
				enemy.queue_free();
				snakesLeft = snakesLeft -1
				label.text = "Cobras restantes: " + str(snakesLeft)
			

			
			
	
	move_and_slide()
	
