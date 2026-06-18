@tool
class_name Mutagen extends Node2D


@export_enum("red", "green", "blue") var mutation_color = "red":
	set(mc):
		mutation_color = mc
		_update_color.call_deferred()


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collection_area: Area2D = $CollectionArea



func _ready() -> void:
	_update_color()
	collection_area.body_entered.connect(_collect)


func _collect(player:Player) -> void:
	var combined = MutagenColor.resolve_multiple(mutation_color, player.mutagen_color.key)
	player.mutate(combined)


func _update_color() -> void:
	if sprite_2d:
		sprite_2d.modulate = MutagenColor.resolve(mutation_color).color
