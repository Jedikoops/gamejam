extends Control


@onready var button_audio: AudioStreamPlayer2D = $ButtonAudio
@onready var victory_audio: AudioStreamPlayer2D = $VictoryAudio
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var high: Label = $High
@onready var score: Label = $Score

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	victory_audio.play()
	Score._check_score()
	score.text += Score._print_score()
	high.text += Score._print_highscore()



func _on_start_pressed() -> void:
	animation_player.play("buttonpress")


func _change_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://UI/mainmenu.tscn")
