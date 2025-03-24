extends Area2D

@export var yeetForce: float = 800.0

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("yeet"):
		body.yeet(yeetForce)
