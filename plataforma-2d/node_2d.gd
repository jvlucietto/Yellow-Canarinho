extends Area2D
@onready var game_manager: Node = %gameManager
@onready var heart_container: Area2D = $"."
@onready var one_up_sound: AudioStreamPlayer = $one_up_sound



func _on_body_entered(body: Node2D) -> void:
	game_manager.addLife();
	heart_container.queue_free();
	
