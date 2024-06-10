extends Area2D

var player
var speed = 1.0  # adjust this value to control the enemy's speed

func _ready():
	player = $"../Player"

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	position += direction
