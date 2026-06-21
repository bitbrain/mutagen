extends Node


var _times:Array[float] = []
var _current_start_time = 0
var _start_time = 0
var _stage = 1


func next_stage() -> void:
	_stage += 1
	
	
func get_current_stage() -> int:
	return _stage


func get_current_stage_time_string() -> String:
	return _format_time(get_current_stage_time())
	
	
func get_total_time_string() -> String:
	return _format_time(get_total_time())
	

func get_total_time() -> float:
	return Time.get_unix_time_from_system() - _start_time


func get_current_stage_time() -> float:
	return Time.get_unix_time_from_system() - _current_start_time


func get_stage_times() -> Array[float]:
	return _times
	
	
func get_stage_time_strings() -> Array[String]:
	var string_times:Array[String] = []
	for i in _times:
		string_times.append(_format_time(i))
	return string_times


func get_stage_time_millis(stage:int) -> float:
	if _times.size() < stage:
		return 0
	return _times[stage]


func finish_stage_time() -> void:
	_times.append(get_current_stage_time())


func start_stage_time() -> void:
	_current_start_time = Time.get_unix_time_from_system()
	if _start_time == 0:
		_start_time = _current_start_time


func reset() -> void:
	_current_start_time = 0
	_start_time = 0
	_times.clear()
	_stage = 1


func _format_time(total_seconds:float) -> String:
	var seconds = fmod(total_seconds, 60.0)
	var minutes = int(total_seconds / 60.0) % 60
	
	var total_ms = total_seconds * 1000.0
	var minutes_ms = minutes * 60000.0
	var seconds_ms = int(seconds) % 1000 * 1000.0
	
	var millis = floor((total_ms - minutes_ms - seconds_ms))
	return "%02d:%02d:%03d" % [minutes, seconds, millis]
