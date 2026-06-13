@tool
extends Node2D


@export var next:PackedScene


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	if not Engine.is_editor_hint():
		PlayerStats.reset()
	area_2d.body_entered.connect(_player_entered)
	

func _player_entered(player:Player) -> void:
	PlayerStats.commit()
	get_tree().change_scene_to_packed(next)
	
	
