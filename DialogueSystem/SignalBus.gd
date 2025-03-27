extends Node

@onready var playerPos: Vector2 = Vector2.ZERO

signal triggerDialogue(textKey)

signal interuptDialogue

signal openDoor(doorKey)
signal closeDoor(doorKey)

func setPlayerPos(newPos: Vector2): playerPos = newPos
func getPlayerPos(): return playerPos
