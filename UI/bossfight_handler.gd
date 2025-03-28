extends Node2D

@export var boss: PackedScene
@export var portal: PackedScene
var thePortal
@onready var can: Area2D = $DialogueArea
@onready var can_col: CollisionShape2D = $DialogueArea/CollisionShape2D

func _ready() -> void:
	SignalBus.connect("openDoor", Callable(self, "openSelf"))
	$BossHealth/HealthBar.visible = false
	can_col.disabled = true
	can.visible = false

func setHealthbar(value):
	$BossHealth/HealthBar.value = value

func openSelf(interactableKey):
	match interactableKey:
		"OpenPortal":
			thePortal = portal.instantiate()
			add_child(thePortal)
			thePortal.position = Vector2(-2015, 170)
			$FirstDialogue.position = Vector2(0, 10000)
			$SecondDialogue.position = Vector2(0, 100)
			can_col.disabled = false
			can.visible = true
		"StartFight":
			can.queue_free()
			remove_child(thePortal)
			thePortal.queue_free()
			$BossHealth/HealthBar.visible = true
			var newBoss = boss.instantiate()
			add_child(newBoss)
			$SecondDialogue.position = Vector2(0, 10000)
		"MainEntrance":
			$FirstEncounter.queue_free()
		"FINAL_BOSS":
			$SecondEncounter.queue_free()
