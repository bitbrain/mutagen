extends Node2D

# FIXME: cannot use this! Godot seems to break completely here... :(
#const STAGE_1 = preload("res://scenes/stages/stage_1.tscn")

const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3


@onready var button: Button = %Button
@onready var token_count: Label = %TokenCount


func _ready() -> void:
	var tokens = PlayerStats.get_tokens()
	PlayerStats.reset(true)
	token_count.text = "You found " + str(tokens) + "token" + ("" if tokens == 1 else "s")
	button.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/stages/stage_1.tscn"))

	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)\
	.set_delay(TRANSITION_DELAY)
