@tool
extends Node2D


signal teleport_attempted


@export var next:PackedScene


@onready var area_2d: Area2D = $Area2D
@onready var portal_sprite: AnimatedSprite2D = $Sprite2D


func _ready() -> void:
	if not Engine.is_editor_hint():
		portal_sprite.visible = false
	area_2d.body_entered.connect(_player_entered)
	

func open_portal() -> void:
	portal_sprite.visible = true
	
	
func is_portal_open() -> bool:
	return portal_sprite.visible
	

func _player_entered(player:Player) -> void:
	if not is_portal_open():
		# sorry bro :( you gotta collect some tokens first.
		teleport_attempted.emit()
		return
	PlayerStats.finish_stage_time(PlayerStats.get_current_stage())
	PlayerStats.next_stage()
	PlayerStats.start_stage_time()
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
	.finished.connect(get_tree().change_scene_to_packed.bind(next))
	
