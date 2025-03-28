extends Control
@onready var health_bar: TextureProgressBar = $HealthBar
var my_health
@onready var shake_anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	health_bar.value = health_bar.max_value
	my_health = health_bar.value


func _update_text(max_health: float, curr_health: float):
	shake_anim.stop()
	my_health = health_bar.value
	health_bar.value = 100*(curr_health/max_health)
	print(curr_health)
	print(max_health)
	print((curr_health/max_health))
	if(curr_health < max_health && health_bar.value != my_health):
		shake_anim.play("shake")
	
