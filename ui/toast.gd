extends CanvasLayer


@export var display_duration = 1.5
@export var fade_in_duration = 0.3
@export var fade_out_duration = 1.0


@onready var label: Label = %Label


func _ready() -> void:
	if not Engine.is_editor_hint():
		label.modulate.a = 0.0


func show_text(text:String) -> void:
	label.text = text
	var text_tween = create_tween()
	text_tween.tween_property(label, "modulate:a", 1.0, fade_in_duration)
	var fade_out_tween = create_tween()
	fade_out_tween.tween_property(label, "modulate:a", 0.0, fade_out_duration)\
	.set_delay(display_duration)
	
