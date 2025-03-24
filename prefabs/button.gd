extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal pressed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "PlayerBody"):
		animation_player.play("pressed")

func _pressed():
	pressed.emit()
