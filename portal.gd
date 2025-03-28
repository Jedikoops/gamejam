extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.position.x = -100
	$Timer.start()
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://UI/mainmenu.tscn")
