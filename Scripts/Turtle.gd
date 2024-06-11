extends Area2D

var player
var speed = 100.0  # adjust this value to control the enemy's speed

func _ready():
	player = $"../Player"

func _process(delta):
	
	position += position.direction_to(player.position) * speed * delta
