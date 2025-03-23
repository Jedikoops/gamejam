extends Node2D
class_name giraffe

@onready var enemy_hurt: enemy_hurt = $enemy_hurt


func _on_enemy_hurt_ded() -> void:
	print("i died")


func _hurt(value):
	enemy_hurt._hurt(value)
