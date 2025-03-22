extends Area2D
@onready var label: Label = $hiddenLabel

var play_text = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(_area: Area2D) -> void:
	print("hello")


func _on_body_entered(_body: Node2D) -> void:
	_become_visible()

func _become_visible():
	label.visible = true


func _on_body_exited(_body: Node2D) -> void:
	label.visible = false
