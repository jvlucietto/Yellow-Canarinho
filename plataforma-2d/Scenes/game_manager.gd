extends Node
@onready var player: CharacterBody2D = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var heart_container: Area2D = $"../HeartContainer"
@onready var damage_sound: AudioStreamPlayer2D = $"../Player/damageSound"
@onready var one_up_sound: AudioStreamPlayer = $"../one_up_sound"

var lives = 2;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func addLife():
	lives += 1;
	one_up_sound.play();
	await get_tree().create_timer(0.5).timeout;
	one_up_sound.stop();
	

func takeDamage():
	lives -= 1
	player.animated_sprite_2d.set_self_modulate(Color.RED)	
func damageTaken():
	player.velocity.y = -200;
	player.velocity.x += 400;
	damage_sound.play();
	await get_tree().create_timer(0.5).timeout
	player.animated_sprite_2d.set_self_modulate(Color.WHITE)
	
	

		
