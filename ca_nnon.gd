extends Area2D

@export var projectile: PackedScene
@export var maxHealth: int = 3
@export var fireRate: float = 1.0
@onready var health: int = maxHealth
@onready var target: Node2D = null

func _ready() -> void:
	$AnimatedSprite2D.play("None")
	$AttackTimer.wait_time = fireRate

func _process(delta: float) -> void:
	if target != null:
		$Gun.look_at(target.position)
	else:
		$AttackTimer.stop()

func _hurt(damage):
	health -= damage
	if(health <= 0):
		queue_free()

func _on_detect_player_body_entered(body: Node2D) -> void:
	#print("hi")
	if body.has_method("yeet"):
		$AttackTimer.start()
		target = body
	pass # Replace with function body.w

func _on_detect_player_body_exited(body: Node2D) -> void:
	$AttackTimer.stop()
	target = null
	pass # Replace with function body.

func _on_attack_timer_timeout() -> void:
	print(target.position)
	if target == null: return
	var newProj = projectile.instantiate()
	#print()
	#newProj.look_at(target.position)
	var ranging = (target.position - position).length()/3
	newProj.linear_velocity = (((target.position + Vector2.UP * ranging) - position).normalized() * 1000)
	add_child(newProj)
	pass # Replace with function body.

func death() -> void:
	$Sprite2D.visible = false
	$Gun/Sprite2D2.visible = false
	$AttackTimer.stop()
	$AnimatedSprite2D.play("kaBoom")
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	pass # Replace with function body.
