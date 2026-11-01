extends Area2D
@onready var fake_blocks: Node = $"../fakeBlocks"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var doors_opened: AudioStreamPlayer = $doors_opened





func _on_body_entered(body: Node2D) -> void:
		if is_instance_valid(fake_blocks):
			for blocks in fake_blocks.get_children():
				blocks.queue_free();
			animated_sprite_2d.play("buttonPressed");
			doors_opened.play();
	
