extends Control
@onready var health_bar: TextureProgressBar = $HealthBar
	
func _ready() -> void:
	health_bar.value = health_bar.max_value

func _update_text(max_health: float, curr_health: float):
	health_bar.value = 100*(curr_health/max_health)
	print(curr_health)
	print(max_health)
	print((curr_health/max_health))
