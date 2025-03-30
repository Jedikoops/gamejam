extends Control
@onready var health_bar: TextureProgressBar = $HealthBar
var my_health
var timer
@onready var shake_anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	timer = 0.0
	health_bar.value = health_bar.max_value
	my_health = health_bar.value

func _process(delta: float) -> void:
	timer += delta
	var newTime = "%d:" % floor(timer/60.0) + "%05.2f" % snapped(fmod(timer,60), 0.01)
	
	Score._set_current_score(timer);
	$SpeedRunTimer.text = newTime
	

func _update_text(max_health: float, curr_health: float):
	shake_anim.stop()
	my_health = health_bar.value
	health_bar.value = 100*(curr_health/max_health)
	print(curr_health)
	print(max_health)
	print((curr_health/max_health))
	if(curr_health < max_health && health_bar.value != my_health):
		shake_anim.play("shake")
	
