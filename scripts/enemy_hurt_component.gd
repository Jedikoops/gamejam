extends AudioStreamPlayer
class_name enemy_hurt
@export var anim: AnimationPlayer

var health = 3
signal ded

func _hurt(value: int):
	health -= value
	if(anim != null):
		anim.play("hurt")
	play()
	if(health <= 0):
		_dead()

func _dead():
	ded.emit()
