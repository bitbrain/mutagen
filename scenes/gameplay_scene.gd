extends Node2D


@onready var player: Player = $Player
@onready var tokens_label: Label = %TokensLabel



func _ready() -> void:
	PlayerStats.reset()
	tokens_label.text = str(PlayerStats.get_tokens())
	PlayerStats.token_gathered.connect(func(tokens): tokens_label.text = str(tokens))
	player.mutated.connect(_player_mutated)
	
	# TODO: figure out virtual keyboard support on mobile
	#if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
	#	DisplayServer.virtual_keyboard_show("")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)
