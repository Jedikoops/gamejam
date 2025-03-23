extends Node2D

@onready var spawnPoint: Area2D = $StartPoint

func getSpawnPos():
	return spawnPoint.global_position

func setSpawn(newSpawn):
	spawnPoint.deactivate()
	spawnPoint = newSpawn
