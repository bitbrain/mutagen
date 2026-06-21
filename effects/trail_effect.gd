extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(queue_free)
	var anims = ["v1", "v2"]
	animated_sprite_2d.play(anims.pick_random())
