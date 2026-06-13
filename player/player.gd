class_name Player extends CharacterBody2D


signal mutated(color:MutagenColor)


const CELL_SIZE = 8


@onready var input_throttle_timer: Timer = $InputThrottleTimer
@onready var input_delay_timer: Timer = $InputDelayTimer


var movable = true
var pressing = false
var mutagen_color = MutagenColor.DEFAULT


func _ready() -> void:
	input_throttle_timer.timeout.connect(_on_input_throttle)
	input_delay_timer.timeout.connect(func(): pressing = true)

func _physics_process(delta: float) -> void:
	if pressing and not Input.is_anything_pressed():
		pressing = false
	if not pressing and Input.is_anything_pressed():
		if input_delay_timer.is_stopped():
			input_delay_timer.start()
	if not movable:
		return
	var motion = Vector2()
	if input_delay_timer.is_stopped():
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
	else:
		if Input.is_action_just_pressed("walk_left"):
			motion.x -= CELL_SIZE
			movable = false
		if Input.is_action_just_pressed("walk_right"):
			motion.x += CELL_SIZE
			movable = false
		if Input.is_action_just_pressed("walk_up"):
			motion.y -= CELL_SIZE
			movable = false
		if Input.is_action_just_pressed("walk_down"):
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
