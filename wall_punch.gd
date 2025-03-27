extends Area2D

var punching = false

func _ready() -> void:
	$StaticBody2D.position = Vector2(500, 0)
	$AnimatedSprite2D.play("Wall")

func _on_body_entered(body: Node2D) -> void:
	if not punching && body.has_method("yeetX"):
		$StaticBody2D.position = Vector2.ZERO
		$AnimatedSprite2D.play("Punch")
		body.yeet(300.0)
		body.yeetX(10000.0)
		body.take_damage(5)
		punching = true
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("Wall")
	$StaticBody2D.position = Vector2(500, 0)
	punching = false
	pass # Replace with function body.
