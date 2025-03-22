extends CharacterBody2D

@onready var weapon_anim: AnimationPlayer = $WeaponAnim
@onready var player_anchor: Node2D = $PlayerAnchor

@onready var area_2d: Area2D = $PlayerAnchor/Shoulder/WeaponAnchor/Area2D

@onready var anim_mouse: AnimatedSprite2D = $PlayerAnchor/AnimMouse
@onready var shoulder: Node2D = $PlayerAnchor/Shoulder
@onready var weapon_sprite: Sprite2D = $PlayerAnchor/Shoulder/WeaponAnchor/Sprite2D

var right
var jump
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	right = true
	_play_idle()
	jump = false

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if is_on_floor():
		pass
		#GroundMovement
		if Input.is_action_pressed("jump"):
			jump = true
			#you might want to make a function to stagger the jump_velocity
			velocity.y = JUMP_VELOCITY
			if right:
				anim_mouse.play("jumpright")
			else:
				anim_mouse.play("jumpleft")

		if direction:
			velocity.x = direction * SPEED
			if direction < 0:
				anim_mouse.play("walkleft")
				right = false
			else:
				anim_mouse.play("walkright")
				right = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if(right):
				anim_mouse.play("idleright")
			else:
				anim_mouse.play("idleleft")
		
	else:
		velocity += get_gravity() * delta

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
