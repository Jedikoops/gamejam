extends Node2D
class_name giraffe
@onready var anim_giraffe: AnimationPlayer = $AnimGiraffe
@onready var bonk: AudioStreamPlayer = $AudioStreamPlayer

var health = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hurt(value: int):
	health -= value
	anim_giraffe.play("hurt")
	bonk.play()
	if(health <= 0):
		queue_free() #this cancels out the last sound because the sound is coming f rom the gi raff
