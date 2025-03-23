extends StaticBody2D

@export var openKey: String = "NO_KEY"

func _ready() -> void:
	SignalBus.connect("openDoor", Callable(self, "openSelf"))

func openSelf(interactableKey):
	if interactableKey == openKey:
		$CollisionShape2D.disabled = true
		$TextureRect.visible = false
