extends Node2D


const Stage1 = preload("res://scenes/stages/stage_1.tscn")


@onready var play: Button = %Play
@onready var quit: Button = %Quit


func _ready() -> void:
	play.pressed.connect(func(): get_tree().change_scene_to_packed(Stage1))
	quit.pressed.connect(func(): get_tree().quit())
