extends CharacterBody2D


const SPEED = 300
var screen_size
var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func chkAction(dir):
	return Input.is_action_pressed(dir)

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var is_moving
	
	# movement
	if chkAction("move_right"):
		velocity.x += SPEED * delta
		$octopus.play("move_horizontal")
		$octopus.flip_h = false
	if chkAction("move_left"):
		velocity.x -= SPEED * delta
		$octopus.play("move_horizontal")
		$octopus.flip_h = true
	if chkAction("move_up"):
		velocity.y -= SPEED * delta
		$octopus.play("move_vertical")
		$octopus.flip_v = false
	if chkAction("move_down"):
		velocity.y += SPEED * delta
		$octopus.play("move_vertical")
		$octopus.flip_v = true
	if chkAction("stop_move"):
		velocity.x = 0
		velocity.y = 0
	#if chkAction("attack"):
		#$octopus.play("attack")
	
	position += velocity * delta

	# You may want to limit the velocity to prevent the octopus from moving too fast
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	if abs(velocity.x) > 0.1 or abs(velocity.y) > 0.1:
		is_moving = true
	
	#play idle when not moving
	if not is_moving:
		$octopus.play("idle")

func take_damage(dmg):
	health -= dmg
	
	if health > 0:
		$octopus.play("damage")
	else:
		$octopus.play("death")
