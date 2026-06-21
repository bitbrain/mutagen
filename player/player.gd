class_name Player extends CharacterBody2D


signal mutated(color:MutagenColor)


const CELL_SIZE = 8
const TrailEffect = preload("res://effects/trail_effect.tscn")
const MUTATE_SOUND = preload("res://assets/mutate.ogg")


@onready var input_throttle_timer: Timer = $InputThrottleTimer
@onready var input_delay_timer: Timer = $InputDelayTimer
@onready var sprite: AnimatedSprite2D = $Sprite2D


var movable = true
var pressing = false
var frozen = false
var mutagen_color = MutagenColor.DEFAULT
var last_position:Vector2 = Vector2.ZERO
var animate_offset_tween


func _ready() -> void:
	input_throttle_timer.timeout.connect(_on_input_throttle)
	input_delay_timer.timeout.connect(func(): pressing = true)

func _physics_process(delta: float) -> void:
	if frozen:
		return
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
			
	last_position = position
	
	move_and_collide(motion)
	
	# avoid awkward positioning between pixels
	position = position.snapped(Vector2(CELL_SIZE, CELL_SIZE))
	
	if last_position.direction_to(position).length() > 0:
		var trail_effect = TrailEffect.instantiate() as Node2D
		trail_effect.position = last_position
		trail_effect.modulate = modulate
		get_parent().add_child(trail_effect)
		
		var distance = position - last_position
		
		# animate sprite
		if animate_offset_tween:
			animate_offset_tween.stop()
		sprite.offset = -distance
		animate_offset_tween = create_tween()
		animate_offset_tween.tween_property(sprite, "offset", Vector2.ZERO, 0.05)
		
		
		
func mutate(mutagen_color:MutagenColor) -> void:
	self.mutagen_color = mutagen_color
	modulate = mutagen_color.color
	mutated.emit(mutagen_color)
	AudioManager.play_sound(MUTATE_SOUND)


func _on_input_throttle() -> void:
	movable = true
