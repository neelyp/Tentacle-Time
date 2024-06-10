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
	
	position += velocity * delta

	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	if abs(velocity.x) > 0.1 or abs(velocity.y) > 0.1:
		is_moving = true
	
	#play idle when not moving
	if not is_moving:
		$octopus.play("idle")

func _input(event):
	if chkAction("attack"):
		shoot_projectile(get_global_mouse_position())
		

func shoot_projectile(target_position):
	var direction = (target_position - position).normalized()
	var projectile = load("res://Scenes/Ink.tscn").instantiate()
	add_child(projectile)
	projectile.position = position
	projectile.linear_velocity = direction * 500

func take_damage(dmg):
	health -= dmg
	
	if health > 0:
		$octopus.play("damage")
	else:
		$octopus.play("death")
