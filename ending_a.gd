extends Control

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/mainmenu.tscn")
	pass # Replace with function body.
