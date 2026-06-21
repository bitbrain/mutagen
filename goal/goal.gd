@tool
extends Node2D


const GATE_SOUND = preload("uid://7evupsmbw7t5")
const WARP_SOUND = preload("uid://drdr2povry305")


signal teleport_attempted
signal portal_opened


@export var next:PackedScene


@onready var area_2d: Area2D = $Area2D
@onready var portal_sprite: AnimatedSprite2D = $Sprite2D
@onready var goal_timer: Timer = $GoalTimer
@onready var post_open_timer: Timer = $PostOpenTimer


var opened = false


func _ready() -> void:
	if not Engine.is_editor_hint():
		portal_sprite.visible = false
	area_2d.body_entered.connect(_player_entered)
	portal_sprite.animation_finished.connect(func():
		if portal_sprite.animation == "open":
			portal_sprite.play("default")
			post_open_timer.start()
		)
	goal_timer.timeout.connect(func():
		portal_sprite.play("open")
		portal_sprite.visible = true
		var abberation_tween = create_tween()
		VFX.screenshake(200.0, 4.0)
		abberation_tween.tween_property(VFX, "aberration", 0.025, 1.0)
		abberation_tween.tween_property(VFX, "aberration", 0.005, 0.5)
	)
	# add slight delay after open for juice
	post_open_timer.timeout.connect(func():
		opened = true
		portal_opened.emit()
		)
	

func open_portal() -> void:
	AudioManager.play_sound(GATE_SOUND)
	goal_timer.start()

	
func is_portal_open() -> bool:
	return opened
	

func _player_entered(node:Node2D) -> void:
	if not node is Player:
		return
	var player = node as Player
	if not is_portal_open():
		# sorry bro :( you gotta collect some tokens first.
		teleport_attempted.emit()
		return
	AudioManager.play_sound(WARP_SOUND)
	PlayerStats.finish_stage_time()
	PlayerStats.next_stage()
	PlayerStats.start_stage_time()
	player.frozen = true
	var transition_tween = create_tween()
	transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
	.finished.connect(func():
		player.frozen = false
		get_tree().change_scene_to_packed(next)
		)
	
