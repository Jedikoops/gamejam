extends CharacterBody2D

@onready var weapon_anim: AnimationPlayer = $WeaponAnim
@onready var player_anchor: Node2D = $PlayerAnchor

@onready var area_2d: Area2D = $PlayerAnchor/Shoulder/WeaponAnchor/Area2D

@onready var anim_mouse: AnimatedSprite2D = $PlayerAnchor/AnimMouse
@onready var shoulder: Node2D = $PlayerAnchor/Shoulder
@onready var weapon_sprite: Sprite2D = $PlayerAnchor/Shoulder/WeaponAnchor/Sprite2D

var right
var jump
const FAST = 300.0
const SLOW = 100.0
var speed
const JUMP_VELOCITY = -400.0
var jump_velocity
const MIN_JUMP = -300.0
const MAX_JUMP = -500.0
const JUMP_CHARGERATE = 300.0



func _ready() -> void:
	right = true
	_play_idle()
	jump = false
	speed = FAST
	jump_velocity = MIN_JUMP

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	
		#Calculate Direction
	if  direction:
			if direction < 0:
				right = false
			else:
				right = true
	
	if is_on_floor():
		#GroundMovement
		if Input.is_action_just_pressed("jump"):
			jump = true
		if Input.is_action_pressed("jump"):
			#you might want to make a function to stagger the jump_velocity
			if(jump):
				if right:
					anim_mouse.play("jumpreadyright")
				else:
					anim_mouse.play("jumpreadyleft")
			if anim_mouse.frame == 3:
				jump = false
			if(!jump):
				if right:
					anim_mouse.play("jumpholdright")
				else:
					anim_mouse.play("jumpholdleft")
				
			
		
		elif  direction: #velocity and animations
			if direction < 0:
				anim_mouse.play("walkleft")
			else:
				anim_mouse.play("walkright")
		else:
			if(right):
				anim_mouse.play("idleright")
			else:
				anim_mouse.play("idleleft")
		
	else: #not on floor
		if(velocity.y < 0): #going up
			if(right):
				anim_mouse.play("fallupright")
			else:
				anim_mouse.play("fallupleft")
		else:
			if(right):
				anim_mouse.play("falldownright")
			else:
				anim_mouse.play("falldownleft")
	
	
	#Movement
	if(is_on_floor()):
		if(Input.is_action_just_released("jump")):
			velocity.y = jump_velocity
			jump_velocity = MIN_JUMP
			
		if(Input.is_action_pressed("jump")):
			speed = move_toward(speed, SLOW, FAST*delta)
			jump_velocity = move_toward(jump_velocity, MAX_JUMP, delta*JUMP_CHARGERATE)
		else:
			speed = FAST
	else:
		velocity += get_gravity() * delta
	
				
	if direction: #velocity and animations
		velocity.x = direction * speed
	else:
		if(is_on_floor()):
			velocity.x = move_toward(velocity.x, 0, FAST)

	#WeaponAttack
	if Input.is_action_just_pressed("attack"):
		weapon_anim.play("attack")
	if right:
		shoulder.scale.x = 1
		weapon_sprite.z_index = 11
	else:
		shoulder.scale.x = -1
		weapon_sprite.z_index = 9
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()
	
func _play_idle():
	weapon_anim.play("idle")


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if(area.get_parent().get_class() == "Node2D"):
		area.get_parent()._hurt()
		print("hit")
