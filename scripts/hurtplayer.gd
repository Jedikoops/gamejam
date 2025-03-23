class_name HurtPlayer
extends Area2D

@export var damage: int

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "PlayerBody"):
		body.take_damage(damage)

	
