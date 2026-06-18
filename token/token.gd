@tool
extends Node2D


const COLLECT_SOUND = preload("res://assets/collect.ogg")


@onready var area_2d: Area2D = $Area2D



func _ready() -> void:
	area_2d.body_entered.connect(_player_entered)


func _player_entered(player:Player) -> void:
	PlayerStats.increment_new_tokens()
	AudioManager.play_sound(COLLECT_SOUND)
	queue_free()
