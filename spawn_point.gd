extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("Deactivated")

func _on_area_entered(area: Area2D) -> void:
	$AnimatedSprite2D.play("Activating")
	get_parent().setSpawn(self)

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("Activated")

func deactivate():
	$AnimatedSprite2D.play("Deactivated")
