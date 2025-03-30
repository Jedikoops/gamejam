extends Node

var HIGHSCORE: float
var SCORE: float
var CURRENT_SCORE: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HIGHSCORE = 10000000000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_current_score(score:float):
	CURRENT_SCORE = score

func _check_score():
	SCORE = CURRENT_SCORE
	_compare_score(SCORE)

func _compare_score(score: float):
	if(HIGHSCORE > score):
		HIGHSCORE = score

func _print_score()->String:
	return "%d:" % floor(SCORE/60.0) + "%05.2f" % snapped(fmod(SCORE,60), 0.01)
func _print_highscore()->String:
	return "%d:" % floor(HIGHSCORE/60.0) + "%05.2f" % snapped(fmod(HIGHSCORE,60), 0.01)
