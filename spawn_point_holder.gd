extends Node2D

@onready var spawnPoint: Area2D = $StartPoint

func _ready() -> void:
	$StartPoint/AnimatedSprite2D.play("Activated")
	$StartPoint.active = true

func getSpawnPos():
	return spawnPoint.global_position

func setSpawn(newSpawn):
	spawnPoint.deactivate()
	spawnPoint = newSpawn
