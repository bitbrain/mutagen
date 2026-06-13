class_name Player extends CharacterBody2D


signal mutated(color:MutagenColor)


const CELL_SIZE = 8


@onready var input_throttle_timer: Timer = $InputThrottleTimer


var movable = true
var mutagen_color = MutagenColor.DEFAULT


func _ready() -> void:
	input_throttle_timer.timeout.connect(_on_input_throttle)

func _physics_process(delta: float) -> void:
	if not movable:
		return
	var motion = Vector2()
	if Input.is_action_pressed("walk_left"):
		motion.x -= CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_right"):
		motion.x += CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_up"):
		motion.y -= CELL_SIZE
		movable = false
	if Input.is_action_pressed("walk_down"):
		motion.y += CELL_SIZE
		movable = false
	
	# FIXME: consider Vector2.snapped() for better collisions
	move_and_collide(motion)
	
		
		
func mutate(mutagen_color:MutagenColor) -> void:
	self.mutagen_color = mutagen_color
	modulate = mutagen_color.color
	mutated.emit(mutagen_color)


func _on_input_throttle() -> void:
	movable = true
