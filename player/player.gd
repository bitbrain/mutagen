class_name Player extends Node2D


const CELL_SIZE = 8
const Colors = preload("res://colors.gd")


@onready var input_throttle_timer: Timer = $InputThrottleTimer


var movable = true



func _ready() -> void:
	input_throttle_timer.timeout.connect(_on_input_throttle)

func _physics_process(delta: float) -> void:
	if not movable:
		return
	if Input.is_action_pressed("walk_left"):
		position.x -= CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_right"):
		position.x += CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_up"):
		position.y -= CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_down"):
		position.y += CELL_SIZE
		movable = false
		
		
func mutate(mutagen:String) -> void:
	modulate = Colors.resolve(mutagen)


func _on_input_throttle() -> void:
	movable = true
