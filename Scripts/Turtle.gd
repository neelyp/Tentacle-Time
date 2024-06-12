extends Area2D

var player
var speed = 100.0  # adjust this value to control the enemy's speed
signal death
var turtle
var groupNum

func _ready():
	add_to_group("Turtle")
	player = $"../Player"
	turtle = $turtle
	groupNum = get_tree().get_nodes_in_group("Turtle").size()

func _process(delta):
	var player_offset = Vector2(-150,-150)
	var direction = position.direction_to(player.position + player_offset)
	position += direction * speed * delta
	
	if direction.x > 0:
		turtle.flip_h = false
		turtle.play("walk")
	elif direction.x < 0:
		turtle.flip_h = true
		turtle.play("walk")
	else:
		turtle.stop()

func _on_body_entered(body):
	if body == $"../Player":
		GameSignals.emit_signal("death")


func _on_area_entered(area):
	if area.is_in_group("Ink"):
		queue_free()
		print(groupNum)
		if get_tree().get_nodes_in_group("Turtle").size() == 1:
			get_tree().change_scene_to_file("res://Scenes/Win.tscn")
