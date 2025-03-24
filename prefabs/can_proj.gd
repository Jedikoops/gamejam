extends RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("flying")
	
func _process(delta: float) -> void:
	if linear_velocity.y == 0:
		linear_velocity = Vector2.ZERO
		rotation = 0
		$AnimatedSprite2D.play("leaving")

func _hurt(damage):
	queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	pass # Replace with function body.
