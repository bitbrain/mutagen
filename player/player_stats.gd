extends Node


var times:Array[float] = []
var current_start_time = 0
var start_time = 0
var stage = 1


func next_stage() -> void:
	stage += 1
	
	
func get_current_stage() -> int:
	return stage


func get_current_stage_time_string() -> String:
	return _format_time(get_current_stage_time())
	
	
func get_total_time_string() -> String:
	return _format_time(get_total_time())
	

func get_total_time() -> float:
	return Time.get_unix_time_from_system() - start_time


func get_current_stage_time() -> float:
	return Time.get_unix_time_from_system() - current_start_time


func get_stage_times() -> Array[float]:
	return times
	
	
func get_stage_time_strings() -> Array[String]:
	var string_times:Array[String] = []
	for i in times:
		string_times.append(_format_time(i))
	return string_times


func get_stage_time_millis(stage:int) -> float:
	if times.size() < stage:
		return 0
	return times[stage]


func finish_stage_time(stage:int) -> void:
	times.append(get_current_stage_time())


func start_stage_time() -> void:
	current_start_time = Time.get_unix_time_from_system()
	if start_time == 0:
		start_time = current_start_time


func reset() -> void:
	current_start_time = 0
	start_time = 0
	times.clear()
	stage = 1


func _format_time(total_seconds:float) -> String:
	var seconds = fmod(total_seconds, 60.0)
	var minutes = int(total_seconds / 60.0) % 60
	var millis = floor((float(total_seconds * 1000.0) - float(minutes * 60000.0) - float(seconds * 1000.0))/100.0)
	return "%02d:%02d" % [minutes, seconds]
