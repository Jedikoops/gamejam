extends Area2D

@onready var targetPos: Vector2 = global_position + Vector2(0, -1000)
var isTracking = false
var canExplode = false
var exploding = false
#@onready var lifeSpanTime: float = 

func _ready() -> void:
	$Timer.start()
	$AnimatedSprite2D.play("Missile")

func _process(delta: float) -> void:
	if not exploding:
		look_at(targetPos)
		global_position += (targetPos - global_position).normalized() * 400.0 * delta
		if (targetPos - global_position).length() > 300.0 && isTracking:
			targetPos = SignalBus.getPlayerPos()
			$CollisionShape2D.scale = Vector2(1.0,1.0)
		if (targetPos - global_position).length() < 10.0 && canExplode:
			exploding = true
			$AnimatedSprite2D.position = Vector2.ZERO
			$AnimatedSprite2D.play("Kaboomboom")
			$Kaboomboom.play()
			$AudioStreamPlayer2D.stop()
		

func _on_timer_timeout() -> void:
	isTracking = true
	canExplode = true
	targetPos = SignalBus.getPlayerPos()
	$Timer.stop()
	pass # Replace with function body.

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
	pass # Replace with function body.
