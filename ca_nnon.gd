extends Area2D

@export var projectile: PackedScene
var target: Node2D = null

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if target != null:
		$Gun.look_at(target.position)
		

func _on_detect_player_body_entered(body: Node2D) -> void:
	print("hi")
	$AttackTimer.start()
	target = body
	pass # Replace with function body.

func _on_detect_player_body_exited(body: Node2D) -> void:
	$AttackTimer.stop()
	target = null
	pass # Replace with function body.

func _on_attack_timer_timeout() -> void:
	var newProj = projectile.instantiate()
	#print()
	#newProj.look_at(target.position)
	newProj.linear_velocity = (((target.position + Vector2.UP * 100) - position).normalized() * 1000)
	add_child(newProj)
	pass # Replace with function body.
