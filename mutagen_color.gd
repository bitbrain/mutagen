class_name MutagenColor extends RefCounted


var color:Color
var key:String


func _init(color:Color, key:String) -> void:
	self.color = color
	self.key = key


const COLOR_MAP = {
	"none": "#ffffff",
	"red": "#f38787",
	"green": "#8dd894",
	"blue": "#5f6ee7",
	"blue,red": "#ff5dcc",
	"blue,green": "#5efdf7",
	"green,red": "#fdfe89"
}

const PLACEHOLDERS = {
	"yellow": "green,red",
	"magenta": "blue,red",
	"cyan": "blue,green"
}


func is_same(other:MutagenColor) -> bool:
	return key == other.key


static var DEFAULT = MutagenColor.new(COLOR_MAP["none"], "none")


static func resolve(key:String) -> MutagenColor:
	if key in PLACEHOLDERS:
		key = PLACEHOLDERS[key]
	if key in COLOR_MAP:
		return MutagenColor.new(COLOR_MAP[key], key)
	return MutagenColor.new(Color(COLOR_MAP["none"])	, "none")


static func resolve_multiple(colorA:String, colorB:String) -> MutagenColor:
	var key_array = [colorA, colorB]
	# ensure to clear cheeky values
	key_array.erase("none")
	key_array.sort()
	var key = ",".join(key_array)
	return resolve(key)
