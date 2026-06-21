extends Panel


const ROW_UI = preload("uid://exhg2ju6qjg1")
const RECORD_SECTION = "record"
const PERSONAL_BEST_KEY = "personal_best"
const PERSONAL_BEST_START_TIME_KEY = "personal_best_start_time"


@onready var timings_container: VBoxContainer = %TimingsContainer
@onready var no_data_container: CenterContainer = %NoDataContainer
	
	
func show_leaderboard() -> void:
	visible = true
	var start_time = _get_personal_best_start_time()
	for child in timings_container.get_children():
		child.queue_free()
	var timings = _get_personal_best()
	for i in range(0, timings.size()):
		var timing_seconds = timings[i]
		var row = ROW_UI.instantiate() as LiveSplitRow
		row.title = "Stage " + str(i + 1)
		row.current_time = timing_seconds - start_time
		row.last_time = row.current_time
		timings_container.add_child(row)
		
	no_data_container.visible =  timings.is_empty()


func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed():
		visible = false



func _get_personal_best() -> Array[float]:
	var def:Array[float] = []
	return PlayerStore.get_value(RECORD_SECTION, PERSONAL_BEST_KEY, def)
	

func _get_personal_best_start_time() -> float:
	return PlayerStore.get_value(RECORD_SECTION, PERSONAL_BEST_START_TIME_KEY, 0.0)
	
