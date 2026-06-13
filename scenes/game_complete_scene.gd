extends Node2D


# FIXME: cannot use this! Godot seems to break completely here... :(
#const STAGE_1 = preload("res://scenes/stages/stage_1.tscn")



@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/stages/stage_1.tscn"))
