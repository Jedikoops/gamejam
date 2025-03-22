extends CanvasLayer

@export_file("*json") var sceneTextFile: String

var sceneText: Dictionary = {}
var currentText: Array = []
var inProgress: bool = false

func _ready() -> void:
	$Background.visible = false
	sceneText = load_scene_text()
	SignalBus.connect("triggerDialogue", Callable(self, "on_display_dialog"))
	SignalBus.connect("interuptDialogue", Callable(self, "interuption"))

func load_scene_text():
	if FileAccess.file_exists(sceneTextFile):
		var file = FileAccess.open(sceneTextFile, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	$Text.text = currentText.pop_front()

func next_line():
	if currentText.size() > 0:
		show_text()
	else:
		finish()

func interuption():
	currentText = []
	finish()

func finish():
	$Text.text = ""
	$Background.visible = false
	inProgress = false
	
func on_display_dialog(text_key):
	if inProgress:
		next_line()
	else:
		$Background.visible = true
		inProgress = true
		currentText = sceneText[text_key].duplicate()
		show_text()
