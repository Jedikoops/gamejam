extends Area2D

@export var dialogueKey = ""
@export var textFinishTriggerKey: String = ""
var triggerReady = false

func _ready() -> void:
	$Label.visible = false
	if $AnimatedSprite2D.sprite_frames != null:
		$AnimatedSprite2D.play("idle")

func _input(event: InputEvent) -> void:
	if triggerReady and event.is_action_pressed("Interact"):
		SignalBus.emit_signal("triggerDialogue", dialogueKey, textFinishTriggerKey)

func _on_area_entered(area: Area2D) -> void:
	$Label.visible = true
	triggerReady = true

func _on_area_exited(area: Area2D) -> void:
	SignalBus.emit_signal("interuptDialogue")
	$Label.visible = false
	triggerReady = false
