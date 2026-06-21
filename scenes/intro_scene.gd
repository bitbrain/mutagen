extends Node2D


const NEXT_SCENE = preload("uid://dcrqqmxm4kkao")


@export var lines:Array[IntroLine]


@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Player
@onready var hold_timer: Timer = $HoldTimer



var current_line_index = -1


func _ready() -> void:
	VFX.transition_amount = 1.5
	player.frozen = true
	_consume_next_line()
	animation_player.animation_finished.connect(func(_anim_name:String):
		hold_timer.start()
		)
	hold_timer.timeout.connect(_consume_next_line)
	

func _input(event: InputEvent) -> void:
	if Input.is_anything_pressed():
		VFX.overlay_opacity = 0.0
		get_tree().change_scene_to_packed(NEXT_SCENE)


func _complete_intro() -> void:
	var fadeout_tween = create_tween()
	fadeout_tween.tween_property(VFX, "overlay_opacity", 1.0, 1.5)\
		.finished.connect(func():
			VFX.overlay_opacity = 0.0
			get_tree().change_scene_to_packed(NEXT_SCENE)
			)
	


func _consume_next_line() -> void:
	current_line_index += 1
	if current_line_index >= lines.size():
		_complete_intro()
		return
	var current_line = lines[current_line_index]
	label.text = current_line.text
	label.visible_ratio = 0.0
	hold_timer.wait_time = current_line.hold_time
	var scroll_tween = create_tween()
	scroll_tween.tween_property(label, "visible_ratio", 1.0, current_line.scroll_text_duration)\
	.finished.connect(func():
		if not current_line.animation:
			# in case animation is present, hold is delayed until
			# animation is finished
			hold_timer.start()
		)
	if current_line.animation:
		animation_player.play(current_line.animation)
