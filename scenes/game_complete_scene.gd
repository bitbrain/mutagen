@tool
extends Node2D

# FIXME: cannot use this! Godot seems to break completely here... :(
#const STAGE_1 = preload("res://scenes/stages/stage_1.tscn")


const ROW_UI = preload("uid://exhg2ju6qjg1")
const TRANSITION_MS = 0.3
const TRANSITION_DELAY = 0.3
const RECORD_SECTION = "record"
const PERSONAL_BEST_KEY = "personal_best"
const PERSONAL_BEST_START_TIME_KEY = "personal_best_start_time"


@export_category("Debugging")
@export var debug = false:
	set(db):
		debug = db
		if Engine.is_editor_hint():
			_refresh.call_deferred()
@export var current_timing:Array[float] = []:
	set(ct):
		current_timing = ct
		if Engine.is_editor_hint():
			_refresh.call_deferred()
@export var previous_timing:Array[float] = []:
	set(pt):
		previous_timing = pt
		if Engine.is_editor_hint():
			_refresh.call_deferred()


@onready var button: Button = %Button

@onready var timings_container: VBoxContainer = %TimingsContainer


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(VFX, "transition_amount", 1.5, TRANSITION_DELAY)
	
	_refresh()
	
	PlayerStats.reset()
	
	button.pressed.connect(func():
		var transition_tween = create_tween()
		PlayerStats.start_stage_time()
		transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
		.finished.connect(get_tree().change_scene_to_file.bind("res://scenes/stages/stage_tutorial.tscn"))
		)
		
	
func _get_personal_best() -> Array[float]:
	var def:Array[float] = []
	return PlayerStore.get_value(RECORD_SECTION, PERSONAL_BEST_KEY, def)
	

func _get_personal_best_start_time() -> float:
	return PlayerStore.get_value(RECORD_SECTION, PERSONAL_BEST_START_TIME_KEY, 0.0)
	
	
func _refresh() -> void:
	var start_time = 0 if debug else PlayerStats.get_start_time()
	var personal_best_start_time = 0 if debug else _get_personal_best_start_time()
	for child in timings_container.get_children():
		child.queue_free()
	var timings = current_timing if self.debug else PlayerStats.get_stage_times()
	var previous_timings = previous_timing if self.debug else _get_personal_best()
	for i in range(0, timings.size()):
		var timing_seconds = timings[i]
		var row = ROW_UI.instantiate() as LiveSplitRow
		row.modulate.a = 0.0
		row.title = "Stage " + str(i + 1)
		row.current_time = timing_seconds - start_time
		row.last_time = row.current_time if previous_timings.is_empty() else previous_timings[i] - personal_best_start_time
		timings_container.add_child(row)
		
		# animate in the numbers
		var reveal_tween = create_tween()
		reveal_tween.tween_property(row, "modulate:a", 1.0, 0.35)\
		.set_delay(i * 0.15)
	
	# determine if there is a new world record
	var last_previous_timing = -1 if previous_timings.is_empty() else previous_timings[previous_timings.size() - 1]
	var last_current_timing = timings[timings.size() - 1] if timings.size() > 0 else -1
	if last_previous_timing < 0 or (last_current_timing - start_time) < (last_previous_timing - personal_best_start_time):
		# new world record, wohoo!
		Toast.show_text("NEW RECORD!")
		PlayerStore.set_value(RECORD_SECTION, PERSONAL_BEST_KEY, timings)
		PlayerStore.set_value(RECORD_SECTION, PERSONAL_BEST_START_TIME_KEY, start_time)
		PlayerStore.save()
		
