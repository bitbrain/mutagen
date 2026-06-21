extends Node


var paused = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = not paused
		get_tree().paused = not paused
		if paused:
			Toast.show_text("Paused")
		else:
			Toast.show_text("Unpaused")
		
