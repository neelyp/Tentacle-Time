extends CharacterBody2D

@onready var shoot_point = $shootPoint

const SPEED = 300
var screen_size
var health = 100
var rel
const INK = preload("res://Scenes/Ink.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var octopus
var shootPoint

func chkAction(dir):
	return Input.is_action_pressed(dir)

func _ready():
	screen_size = get_viewport_rect().size
	octopus = $octopus
	shootPoint = $shootPoint
	GameSignals.death.connect(self.die)

func _physics_process(delta):
	var is_moving
	
	# movement
	if chkAction("move_right"):
		velocity.x += SPEED * delta
		octopus.play("move_horizontal")
		octopus.flip_h = false
		GameSignals.emit_signal("flip_ink", true)
	if chkAction("move_left"):
		velocity.x -= SPEED * delta
		octopus.play("move_horizontal")
		octopus.flip_h = true
		GameSignals.emit_signal("flip_ink", false)
	if chkAction("move_up"):
		velocity.y -= SPEED * delta
		octopus.play("move_vertical")
		octopus.flip_v = false
	if chkAction("move_down"):
		velocity.y += SPEED * delta
		octopus.play("move_vertical")
		octopus.flip_v = true
	if chkAction("stop_move"):
		velocity.x = 0
		velocity.y = 0
	
	position += velocity * delta
	$shootPoint.position = position
	
	if Input.is_action_pressed("attack") and rel:
		var ink = INK.instantiate()
		ink.global_position = shootPoint.position
		get_parent().add_child(ink)
		rel = false
	elif Input.is_action_just_released("attack") and !rel:
		rel = true
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	if abs(velocity.x) > 0.1 or abs(velocity.y) > 0.1:
		is_moving = true
	
	#play idle when not moving
	if not is_moving:
		octopus.play("idle")


func die():
	print("die")
	octopus.play("death")
	get_tree().change_scene_to_file("res://Scenes/Die.tscn")
