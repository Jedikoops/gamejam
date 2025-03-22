extends Area2D

@export var dialogueKey = ""
var triggerReady = false


func _input(event: InputEvent) -> void:
	if triggerReady and event.is_action_pressed("Interact"):
		SignalBus.emit_signal("triggerDialogue", dialogueKey)


func _on_area_entered(area: Area2D) -> void:
	triggerReady = true

func _on_area_exited(area: Area2D) -> void:
	SignalBus.emit_signal("interuptDialogue")
	triggerReady = false
