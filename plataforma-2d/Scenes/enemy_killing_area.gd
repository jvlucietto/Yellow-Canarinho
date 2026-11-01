extends Area2D
@onready var game_manager: Node = $"../../../gameManager"




func _on_body_entered(body: Node2D) -> void:
	game_manager.takeDamage();
	game_manager.damageTaken();
	if(game_manager.lives <= -1):
		body.get_node("CollisionShape2D").queue_free();
		print(body ," got destroyed")
		get_tree().reload_current_scene();
