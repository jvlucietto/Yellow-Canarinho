extends Node2D
@onready var counter: Label = $counter
@onready var game_manager: Node = %gameManager

func _process(delta: float) -> void:
	counter.text = str(game_manager.lives) + "x"
