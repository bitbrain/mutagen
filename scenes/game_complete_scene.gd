extends Node2D

# FIXME: cannot use this! Godot seems to break completely here... :(
#const STAGE_1 = preload("res://scenes/stages/stage_1.tscn")



@onready var button: Button = %Button
@onready var token_count: Label = %TokenCount


func _ready() -> void:
	var tokens = PlayerStats.get_tokens()
	PlayerStats.reset(true)
	token_count.text = "You found " + tokens + "token" + ("" if tokens == 1 else "s")
	button.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/stages/stage_1.tscn"))
