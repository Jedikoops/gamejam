extends Node2D
class_name giraffe
@onready var anim_giraffe: AnimationPlayer = $AnimGiraffe
@onready var bonk: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hurt():
	anim_giraffe.play("hurt")
	bonk.play()
	
