extends Area2D

@export var dialogueKey = ""
@export var textFinishTriggerKey: String = ""
var triggerReady = false

@onready var sound_one: AudioStreamPlayer2D = $SoundOne
@onready var sound_two: AudioStreamPlayer2D = $SoundTwo
@onready var sound_three: AudioStreamPlayer2D = $SoundThree

func _ready() -> void:
	$Label.visible = false
	if $AnimatedSprite2D.sprite_frames != null:
		$AnimatedSprite2D.play("idle")

func _input(event: InputEvent) -> void:
	if triggerReady and event.is_action_pressed("Interact"):
		SignalBus.emit_signal("triggerDialogue", dialogueKey, textFinishTriggerKey)
		var i = randi_range(1,3)
		if(i == 1):
			sound_one.play()
			sound_two.stop()
			sound_three.stop()
		if(i == 2):
			sound_one.stop()
			sound_two.play()
			sound_three.stop()
		if(i == 3):
			sound_one.stop()
			sound_two.stop()
			sound_three.play()

func _on_area_entered(area: Area2D) -> void:
	$Label.visible = true
	triggerReady = true

func _on_area_exited(area: Area2D) -> void:
	SignalBus.emit_signal("interuptDialogue")
	$Label.visible = false
	triggerReady = false
