extends Node2D


@onready var player: Player = $Player


func _ready() -> void:
	player.mutated.connect(_player_mutated)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)
