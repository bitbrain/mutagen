@tool
extends Node2D


signal collected


const COLLECT_SOUND = preload("res://assets/collect.ogg")
const COLLECT_EFFECT = preload("res://effects/collect_effect.tscn")
const COLLECT_EFFECT_OFFSET = Vector2(4, 4)


@onready var area_2d: Area2D = $Area2D



func _ready() -> void:
	area_2d.body_entered.connect(_player_entered)


func _player_entered(node:Node2D) -> void:
	if not node is Player:
		return
	AudioManager.play_sound(COLLECT_SOUND)
	var effect = COLLECT_EFFECT.instantiate() as Node2D
	effect.global_position = global_position + COLLECT_EFFECT_OFFSET
	get_parent().add_child(effect)
	collected.emit()
	queue_free()
