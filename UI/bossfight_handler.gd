extends Node2D

@export var boss: PackedScene

func _ready() -> void:
	SignalBus.connect("openDoor", Callable(self, "openSelf"))
	$BossHealth/HealthBar.visible = false

func setHealthbar(value):
	$BossHealth/HealthBar.value = value

func openSelf(interactableKey):
	match interactableKey:
		"OpenPortal":
			$FirstDialogue.position = Vector2(0, 10000)
			$SecondDialogue.position = Vector2(0, 100)
		"StartFight":
			$BossHealth/HealthBar.visible = true
			var newBoss = boss.instantiate()
			add_child(newBoss)
			$SecondDialogue.position = Vector2(0, 10000)
