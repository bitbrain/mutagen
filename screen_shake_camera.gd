class_name ScreenShakeCamera extends Camera2D


var shake_amount = 0.0
var tween


func _process(delta: float) -> void:
	set_offset(Vector2( \
			randf_range(-1.0, 1.0) * shake_amount * delta, \
			randf_range(-1.0, 1.0) * shake_amount * delta \
	))


func shake(intensity:float, duration:float) -> void:
	if tween != null:
		tween.stop()
	shake_amount = intensity
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "shake_amount", 0.0, duration)
