extends Control

@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	animation_player_2.play("start_oneshot")
	
