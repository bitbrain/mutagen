@tool
extends Node2D


signal collected


const COLLECT_SOUND = preload("res://assets/collect.ogg")


@onready var area_2d: Area2D = $Area2D



func _ready() -> void:
	area_2d.body_entered.connect(_player_entered)


func _player_entered(node:Node2D) -> void:
	if not node is Player:
		return
	AudioManager.play_sound(COLLECT_SOUND)
	collected.emit()
	queue_free()
