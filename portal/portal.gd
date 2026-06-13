@tool
class_name Portal extends Node2D


@export_enum("red", "green", "blue", "yellow", "magenta", "cyan") var mutation_color = "red":
	set(mc):
		mutation_color = mc
		_update_color.call_deferred()


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_area: Area2D = $CollisionArea


var mutagen_color:MutagenColor = MutagenColor.DEFAULT
var just_teleported = false


func _ready() -> void:
	_update_color()
	collision_area.body_entered.connect(_player_entered)


func _player_entered(player:Player) -> void:
	if just_teleported:
		just_teleported = false
		return
	if player.mutagen_color.is_same(self.mutagen_color):
		var portals = get_tree().get_nodes_in_group("portal")
		for portal in portals:
			# let's not teleport to self
			if portal.get_instance_id() == get_instance_id():
				continue
			if mutagen_color.is_same(portal.mutagen_color):
				player.global_position = portal.global_position
				portal.just_teleported = true


func _update_color() -> void:
	if sprite_2d:
		sprite_2d.modulate = MutagenColor.resolve(mutation_color).color
	mutagen_color = MutagenColor.resolve(mutation_color)
