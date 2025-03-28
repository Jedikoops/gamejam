extends Node2D

@export var missileScene: PackedScene

var missilesToShoot = 0

var moveTime = 5.0
var moveTimer = -1.0

var targetMove = Vector2.ZERO
var startMove = Vector2.ZERO

var moveOptions = [Vector2(-250, 0), Vector2(0, 0), Vector2(250, 0)]
var missilesPerPhase = [2,4,6]

var health = 30.0
var phase = 1

func _ready() -> void:
	get_parent().setHealthbar(100)
	$BossHitBox/AnimatedSprite2D.play("default")
	$MissileTimer.start()
	$MoveTimer.start()

func _process(delta: float) -> void:
	if moveTimer > 0.0:
		moveTimer -= delta
		$BossHitBox.position = (startMove + (targetMove - startMove) * ((moveTime - moveTimer)/moveTime))
	elif moveTimer != -1.0:
		print("starting timer")
		moveTimer = -1.0
		$BossHitBox.position = targetMove
		$MoveTimer.start()

func _hurt(damage):
	health -= damage
	get_parent().setHealthbar(100*health/30.0)
	if health <= 0:
		deathProtocol()
	elif(health < 10):
		phase = 3
	elif(health < 20):
		phase = 2

func deathProtocol():
	$MoveTimer.stop()
	$MissileTimer.stop()
	$IndividualMissileTimer.stop()

func _on_move_timer_timeout() -> void:
	moveTimer = moveTime
	startMove = $BossHitBox.position
	targetMove = moveOptions[RandomNumberGenerator.new().randi_range(0, 2)]
	$MoveTimer.stop()
	pass # Replace with function body.

func _on_missile_timer_timeout() -> void:
	missilesToShoot = missilesPerPhase[phase - 1]
	$IndividualMissileTimer.start()
	pass # Replace with function body.

func _on_individual_missile_timer_timeout() -> void:
	if missilesToShoot <= 0:
		$IndividualMissileTimer.stop()
		return
	var newMissle = missileScene.instantiate()
	newMissle.position = $BossHitBox.position
	add_child(newMissle)
	missilesToShoot -= 1
	pass # Replace with function body.
