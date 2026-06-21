class_name LiveSplitRow extends Control


@export var current_time:float
@export var last_time:float
@export var title:String


@onready var name_label: Label = $NameLabel
@onready var diff_label: Label = $DiffLabel
@onready var time_label: Label = $TimeLabel


func _ready() -> void:
	name_label.text = title
	diff_label.text = format_diff()
	diff_label.modulate = Color(get_diff_color())
	time_label.text = PlayerStats.format_time(current_time)

func format_diff() -> String:
	var diff = str("%.2f" % get_diff())
	if get_diff() > 0:
		return "+" + diff
	return diff


func get_diff() -> float:
	return last_time - current_time
	
	
func get_diff_color() -> String:
	return '#5dc190' if get_diff() > 0 else '#f38797'
