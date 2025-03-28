extends Area2D

@export var yeetForce: float = 800.0
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("yeet"):
		$AnimatedSprite2D.play("default")
		body.yeet(yeetForce)
		audio_stream_player_2d.play()
