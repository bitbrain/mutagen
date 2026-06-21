extends Node


const FILE_PATH = "user://player-store.cfg"


var config:ConfigFile


func _ready() -> void:
	config = ConfigFile.new()
	config.load(FILE_PATH)



func get_value(section: String, key: String, default: Variant) -> Variant:
	return config.get_value(section, key, default)
	
	
func set_value(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
	
	
func save() -> void:
	config.save(FILE_PATH)
