extends Node2D

# FIXME: cannot use this! Godot seems to break completely here... :(
#const STAGE_1 = preload("res://scenes/stages/stage_1.tscn")

const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3


@onready var button: Button = %Button

@onready var timings_container: VBoxContainer = $CanvasLayer/CenterContainer/VBoxContainer/TimingsContainer
@onready var total_time_label: Label = $CanvasLayer/CenterContainer/VBoxContainer/TotalTimeLabel


func _ready() -> void:
	total_time_label.text = PlayerStats.get_total_time_string()
	var timings = PlayerStats.get_stage_time_strings()
	for timing in timings:
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 6)
		label.text = timing
		timings_container.add_child(label)
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)\
	.set_delay(TRANSITION_DELAY)
	
	button.pressed.connect(func():
		var transition_tween = create_tween()
		PlayerStats.start_stage_time()
		transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
		.finished.connect(get_tree().change_scene_to_file.bind("res://scenes/stages/stage_1.tscn"))
		)
	
