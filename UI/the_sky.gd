extends Node2D

func _ready() -> void:
	for animatedTile in get_children():
		animatedTile.play("default")
