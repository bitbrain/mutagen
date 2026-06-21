extends Panel



func _ready() -> void:
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("guide"):
		visible = not visible
	elif Input.is_anything_pressed() and not Input.is_action_pressed("guide") and visible:
		visible = false
