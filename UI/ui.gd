extends CanvasLayer
@onready var player_ui: Control = $PlayerUI
@onready var player_body: PlayerBody = $"../PlayerBody"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_body.player_ouchie.connect(player_ui_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func player_ui_health() -> void:
	player_ui._update_text(player_body.MAX_HEALTH, player_body.health)
