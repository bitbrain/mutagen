extends Camera2D


const OFFSET = Vector2(100, 50)


const CENTER_DISTANCE = 40
const ROTATE_SPEED = 0.1


var rotation_vector = Vector2(CENTER_DISTANCE, 0)



func _process(delta: float) -> void:
	position = rotation_vector + OFFSET
	rotation_vector = rotation_vector.rotated(ROTATE_SPEED * delta)
