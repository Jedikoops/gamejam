extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var enemy_hurt: enemy_hurt = $enemy_hurt
@onready var detect_player: Area2D = $detect_player
@onready var hurt_collision: CollisionShape2D = $HurtPlayer/HurtCollision
@onready var hurt_player: HurtPlayer = $HurtPlayer


@onready var line_2d: Line2D = $Line2D
var time: float
var prev_pos: Vector2
var sprite_xscale
@export var SPEED = 200
@export var JUMP_HEIGHT = 600
@export var JUMP_DISTANCE = 200
var target: PlayerBody
var patrol
var hop
var fly
var ded
@export var idle_patrol: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.hide()
	JUMP_DISTANCE *= -1
	JUMP_HEIGHT *= -1
	patrol = true
	fly = false
	hop = false
	position.x = line_2d.points[0].x
	time = 0
	sprite_xscale = sprite.scale.x
	sprite.flip_h = true
	ded = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(is_on_floor()):
		fly = false
		rotation_degrees = 0
	else:
		fly = true
	if(target != null):
		if patrol:
			hop = true
		else:
			hop = false
		patrol = false
		
	
	if(patrol && !ded):
		time += delta * SPEED * 1/abs(line_2d.points[0].x-line_2d.points[1].x)
		prev_pos = global_position
		if(!idle_patrol):
			position.x = _cubic(line_2d.points[0].x, line_2d.points[1].x, abs(fmod(time, 2)-1))
			sprite.scale.x = move_toward(sprite.scale.x, sign(fmod(time, 2)-1)*abs(sprite_xscale), 10*delta)
		else:
			sprite.scale.x = move_toward(sprite.scale.x, sprite_xscale * sign(fmod(time, 2)-1), 10*delta) 
			sprite.play("standing")
		detect_player.scale.x = sign(sprite.scale.x)
	else:
		sprite.scale.x = abs(sprite_xscale) * sign(sprite.scale.x)
		if(fly):
			look_at(global_position + (prev_pos - global_position))
			rotation_degrees -= 90
			sprite.play("jumpfly")
		else:
			if(velocity.x != 0):
				sprite.play("jumpcrash")
				velocity.x = move_toward(velocity.x, 0, delta*300)
				rotation_degrees = 0
				if(sprite.frame == 3):
					sprite.pause()
			else:
				sprite.play("jumpgetup")
				if(sprite.frame == 2):
					patrol = true
					idle_patrol = true	
					target = null
	if(hop && !ded):
		sprite.play("jumpready")
		velocity.y = JUMP_HEIGHT
		velocity.x = JUMP_DISTANCE * sign(position.x-target.position.x)
		look_at(target.position)
	if(ded):
		if(is_on_floor()):
			sprite.play("jumpcrash")
			sprite.rotation_degrees = 0
		else:
			sprite.play("jumpfly")
			sprite.rotation_degrees = 90

	
	velocity.y += get_gravity().y * delta
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


func _on_enemy_hurt_ded() -> void:
	
	print("the trash bag is dead")
	velocity.x = -velocity.x - randf_range(-200, 200)
	velocity.y = -velocity.y - 200
	ded = true
	hurt_player.damage = 0
	
