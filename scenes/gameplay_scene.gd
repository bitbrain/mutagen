extends Node2D


const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3


@onready var player: Player = $Player
@onready var times_label: Label = %TimesLabel


var tokens_collected = 0
var total_tokens = 0


func _ready() -> void:
	player.mutated.connect(_player_mutated)
	
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)\
	.set_delay(TRANSITION_DELAY)
	
	var goals = get_tree().get_nodes_in_group("goal")
	var tokens = get_tree().get_nodes_in_group("token")
	
	total_tokens = tokens.size()
	for token in tokens:
		token.collected.connect(func():
			tokens_collected += 1
			if tokens_collected == total_tokens:
				_open_all_goals()
			)
			
	for goal in goals:
		goal.teleport_attempted.connect(func():
			Toast.show_text("Gather more shards to open portal!")
			)
	
	# TODO: figure out virtual keyboard support on mobile
	#if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
	#	DisplayServer.virtual_keyboard_show("")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	times_label.text = PlayerStats.get_total_time_string()


func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)


func _open_all_goals() -> void:
	var goals = get_tree().get_nodes_in_group("goal")
	for goal in goals:
		goal.open_portal()
