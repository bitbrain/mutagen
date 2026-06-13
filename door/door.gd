@tool
extends StaticBody2D


@export_enum("red", "green", "blue", "yellow", "magenta", "cyan") var mutation_color = "red":
	set(mc):
		mutation_color = mc
		_update_color.call_deferred()


@onready var sprite_2d: Sprite2D = $Sprite2D


var mutagen_color:MutagenColor = MutagenColor.DEFAULT


func _ready() -> void:
	_update_color()
	_update_color()

func change_mutation(mutagen_color:MutagenColor) -> void:
	var same_mutation = self.mutagen_color.is_same(mutagen_color)
	visible = not same_mutation
	set_collision_layer_value(1, visible)
	


func _update_color() -> void:
	if sprite_2d:
		sprite_2d.modulate = MutagenColor.resolve(mutation_color).color
	mutagen_color = MutagenColor.resolve(mutation_color)
