@tool
extends Node2D


@export var next:PackedScene


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.body_entered.connect(_player_entered)
	

func _player_entered(player:Player) -> void:
	get_tree().change_scene_to_packed(next)
	
	
