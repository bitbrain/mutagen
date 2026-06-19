extends Node2D


const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3


@onready var player: Player = $Player
@onready var times_label: Label = %TimesLabel



func _ready() -> void:
	player.mutated.connect(_player_mutated)
	
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)\
	.set_delay(TRANSITION_DELAY)

	
	# TODO: figure out virtual keyboard support on mobile
	#if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
	#	DisplayServer.virtual_keyboard_show("")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	times_label.text = PlayerStats.get_total_time_string()

func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)
