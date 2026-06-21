extends Node2D


const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3


@onready var player: Player = $Player
@onready var times_label: Label = %TimesLabel
@onready var camera_2d: ScreenShakeCamera = $Camera2D
@onready var remote_transform_2d: RemoteTransform2D = $Player/RemoteTransform2D


var tokens_collected = 0
var total_tokens = 0


func _ready() -> void:
	player.mutated.connect(_player_mutated)
	
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)
	
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
	
	# we need to wait 1 tick to ensure that player position
	# is properly set to avoid camera moving to player on start
	var delayed_smoothing = func():
		camera_2d.position_smoothing_enabled = true
	delayed_smoothing.call_deferred()
	
	# a bit hacky but that's life.
	VFX.screenshake_requested.connect(camera_2d.shake)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	times_label.text = PlayerStats.get_total_time_string()
	
	#if Input.is_action_just_pressed("test"):
	#	VFX.screenshake(120, 6.0)


func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)


func _open_all_goals() -> void:
	var goals = get_tree().get_nodes_in_group("goal")
	for goal in goals:
		# time for some portal animation magic
		remote_transform_2d.remote_path = ""
		camera_2d.global_position = goal.global_position
		player.frozen = true
		# unfreeze player and take back control once
		# the fancy portal animation has concluded.
		goal.portal_opened.connect(func():
			remote_transform_2d.remote_path = camera_2d.get_path()
			player.frozen = false
			)
		goal.open_portal()
