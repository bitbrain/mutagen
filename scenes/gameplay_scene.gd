extends Node2D


@onready var player: Player = $Player


func _ready() -> void:
	player.mutated.connect(_player_mutated)


func _player_mutated(mutagen_color:MutagenColor):
	get_tree().call_group("door", "change_mutation", mutagen_color)
