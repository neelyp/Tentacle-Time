extends Area2D

const SPEED = 600.0
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Ink")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * SPEED * delta
