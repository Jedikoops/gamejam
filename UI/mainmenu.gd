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
	


func _on_start_pressed() -> void:
	#$StartGameTimer.start()
	animation_player_2.play("play_oneshot")

func _change_scene():
	get_tree().change_scene_to_file("res://UI/tower_of_garbo.tscn")


func _on_start_game_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://UI/tower_of_garbo.tscn")
	pass # Replace with function body.
