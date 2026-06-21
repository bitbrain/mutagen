class_name MutagenColor extends RefCounted


var color:Color
var key:String


func _init(init_color:Color, init_key:String) -> void:
	self.color = init_color
	self.key = init_key


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


static func resolve(this_key:String) -> MutagenColor:
	if this_key in PLACEHOLDERS:
		this_key = PLACEHOLDERS[this_key]
	if this_key in COLOR_MAP:
		return MutagenColor.new(COLOR_MAP[this_key], this_key)	
	return MutagenColor.new(Color(COLOR_MAP["none"]), "none")


static func resolve_multiple(colorA:String, colorB:String) -> MutagenColor:
	# game juice: instantly swap to incompatible color
	# to avoid mandatory swap to 'none' and back.
	if colorA != colorB && "," in colorA:
		return resolve(colorB)
	if colorA != colorB && "," in colorB:
		return resolve(colorA)
	
	var key_array = [colorA, colorB]
	# ensure to clear cheeky values
	key_array.erase("none")
	key_array.sort()
	var this_key = ",".join(key_array)
	return resolve(this_key)
