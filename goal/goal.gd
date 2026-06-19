@tool
extends Node2D


@export var next:PackedScene


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.body_entered.connect(_player_entered)
	

func _player_entered(player:Player) -> void:
	PlayerStats.finish_stage_time(PlayerStats.get_current_stage())
	PlayerStats.next_stage()
	PlayerStats.start_stage_time()
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
	.finished.connect(get_tree().change_scene_to_packed.bind(next))
	
