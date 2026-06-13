extends Node


const COLOR_MAP = {
	"none": "#ffffff",
	"red": "#f38787",
	"green": "#8dd894",
	"blue": "#5f6ee7",
	"blue,red": "#ff5dcc",
	"blue,green": "#5efdf7",
	"green,red": "#fdfe89"
}

static func resolve(key:String) -> Color:
	if key in COLOR_MAP:
		return COLOR_MAP[key]
	return Color(COLOR_MAP["none"])	


static func resolve_multiple(colorA:String, colorB:String) -> Color:
	var key_array = [colorA, colorB]
	key_array.sort()
	var key = ",".join(key_array)
	return resolve(key)
