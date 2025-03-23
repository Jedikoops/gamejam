extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var enemy_hurt: enemy_hurt = $enemy_hurt
@onready var detect_player: Area2D = $detect_player

@onready var line_2d: Line2D = $Line2D
var time: float
var prev_xpos: float
var sprite_xscale
const SPEED = 200
var target: PlayerBody
var patrol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	patrol = true
	position.x = line_2d.points[0].x
	time = 0
	sprite_xscale = sprite.scale.x
	sprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(target != null):
		patrol = false
	
	if(patrol):
		time += delta * SPEED * 1/abs(line_2d.points[0].x-line_2d.points[1].x)
		prev_xpos = position.x
		velocity.y += get_gravity().y * delta
		position.x = _cubic(line_2d.points[0].x, line_2d.points[1].x, abs(fmod(time, 2)-1))
		sprite.scale.x = move_toward(sprite.scale.x, sign(fmod(time, 2)-1)*abs(sprite_xscale), 10*delta)
		detect_player.scale.x = sign(sprite.scale.x)
	else:
		sprite.scale.x = -sprite_xscale
	
	move_and_slide()
	
func _lerp(a:float, b:float, t:float):
	return (1-t)*a + t*b
	
func _cubic(a:float, b:float, t:float):
	return pow(t,2)*(3-2*t)*(abs(a-b)) + b

func _hurt(number):
	enemy_hurt._hurt(number)


func _on_detect_player_body_entered(body: Node2D) -> void:
	
	if body.name == "PlayerBody":
		target = body
		print("found_you")
