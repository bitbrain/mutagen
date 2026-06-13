@tool
extends Node2D


const Colors = preload("res://colors.gd")


@export_enum("red", "green", "blue") var mutation_color = "red":
	set(mc):
		mutation_color = mc
		_update_color.call_deferred()


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collection_area: Area2D = $CollectionArea



func _ready() -> void:
	_update_color()
	collection_area.body_entered.connect(_collect)


func _collect(player:Player) -> void:
	player.mutate(mutation_color)
	queue_free()


func _update_color() -> void:
	sprite_2d.modulate = Colors.resolve(mutation_color)
