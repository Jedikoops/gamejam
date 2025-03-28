extends StaticBody2D

@export var openKey: String = "NO_KEY"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalBus.connect("openDoor", Callable(self, "openSelf"))

func openSelf(interactableKey):
	if interactableKey == openKey:
		$CollisionShape2D.disabled = true
		animation_player.play("open")
		#$TextureRect.visible = false
