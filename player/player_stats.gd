extends Node


var _times:Array[float] = []
var _start_time = 0
	
	
func get_total_time_string() -> String:
	return format_time(get_total_time())
	

func get_total_time() -> float:
	return Time.get_unix_time_from_system() - _start_time


func get_stage_times() -> Array[float]:
	return _times
	
	
func get_start_time() -> float:
	return _start_time


func finish_stage_time() -> void:
	_times.append(Time.get_unix_time_from_system())


func start_stage_time() -> void:
	if _start_time == 0:
		_start_time = Time.get_unix_time_from_system()


func reset() -> void:
	_start_time = 0
	_times.clear()


func format_time(total_seconds:float) -> String:
	var seconds = fmod(total_seconds, 60.0)
	var minutes = int(total_seconds / 60.0) % 60
	
	var total_ms = total_seconds * 1000.0
	var minutes_ms = minutes * 60000.0
	var seconds_ms = int(seconds) % 1000 * 1000.0
	
	var millis = floor((total_ms - minutes_ms - seconds_ms))
	return "%02d:%02d:%03d" % [minutes, seconds, millis]
