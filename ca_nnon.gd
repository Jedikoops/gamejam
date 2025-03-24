extends Area2D

@export var projectile: PackedScene
@export var maxHealth: int = 3
@onready var health: int = maxHealth
@onready var target: Node2D = null

func _ready() -> void:
	pass

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
	print("hi")
	$AttackTimer.start()
	target = body
	pass # Replace with function body.w

func _on_detect_player_body_exited(body: Node2D) -> void:
	$AttackTimer.stop()
	target = null
	pass # Replace with function body.

func _on_attack_timer_timeout() -> void:
	if target == null: return
	var newProj = projectile.instantiate()
	#print()
	#newProj.look_at(target.position)
	var ranging = (target.position - position).length()/4
	newProj.linear_velocity = (((target.position + Vector2.UP * ranging) - position).normalized() * 1000)
	add_child(newProj)
	pass # Replace with function body.
