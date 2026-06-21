extends Node


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			Toast.show_text("Paused")
		else:
			Toast.show_text("Unpaused")
