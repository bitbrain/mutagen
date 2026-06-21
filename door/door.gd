@tool
extends StaticBody2D


@export_enum("red", "green", "blue", "yellow", "magenta", "cyan") var mutation_color = "red":
	set(mc):
		mutation_color = mc
		_update_color.call_deferred()


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


var mutagen_color:MutagenColor = MutagenColor.DEFAULT
var dissolved = false

func _ready() -> void:
	# ensure we always play the normal animation after animation finished
	sprite_2d.animation_finished.connect(func():
		if sprite_2d.animation == "restore":
			sprite_2d.play("default")
		)
	_update_color()


func change_mutation(other_color:MutagenColor) -> void:
	var same_mutation = self.mutagen_color.is_same(other_color)
	set_collision_layer_value(1, not same_mutation)
	if not dissolved and same_mutation:
		dissolved = true
		sprite_2d.play("dissolve")
	if dissolved and not same_mutation:
		dissolved = false
		sprite_2d.play("restore")
	


func _update_color() -> void:
	if sprite_2d:
		sprite_2d.modulate = MutagenColor.resolve(mutation_color).color
	mutagen_color = MutagenColor.resolve(mutation_color)
