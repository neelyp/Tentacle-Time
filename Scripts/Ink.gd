extends Area2D

const SPEED = 600.0
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Ink")
	GameSignals.flip_ink.connect(self._on_flip_ink)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction:
		position += transform.x * SPEED * delta
	else:
		position -= transform.x * SPEED * delta

	var screen_size = get_viewport_rect().size
	if position.x < 0 or position.x > screen_size.x or position.y < 0 or position.y > screen_size.y:
		queue_free()

func _on_flip_ink(dir):
	print(dir)
	direction = dir
