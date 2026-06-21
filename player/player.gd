@tool
class_name Player extends CharacterBody2D


signal mutated(color:MutagenColor)


const CELL_SIZE = 8
const TrailEffect = preload("res://effects/trail_effect.tscn")
const MUTATE_SOUND = preload("res://assets/mutate.ogg")



@export var animation_override = "":
	set(ao):
		animation_override = ao
		play_call = func():
			if sprite:
				sprite.play(animation_override)
		play_call.call_deferred()

@export var flip_override = false:
	set(fo):
		flip_override = fo
		flip_call = func():
			if sprite:
				sprite.flip_h = flip_override
		flip_call.call_deferred()


@onready var input_throttle_timer: Timer = $InputThrottleTimer
@onready var input_delay_timer: Timer = $InputDelayTimer
@onready var sprite: AnimatedSprite2D = $Sprite2D

var play_call
var flip_call

var movable = true
var pressing = false
var frozen = false
var mutating = false
var mutagen_color = MutagenColor.DEFAULT
var last_position:Vector2 = Vector2.ZERO
var animate_offset_tween
var last_distance = Vector2.ZERO


func _ready() -> void:
	if flip_call:
		flip_call.call_deferred()
	if play_call:
		play_call.call_deferred()
	if Engine.is_editor_hint():
		return
	input_throttle_timer.timeout.connect(_on_input_throttle)
	input_delay_timer.timeout.connect(func(): pressing = true)

func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if mutating:
		return
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
	
	var distance = position - last_position
	
	# flip sprite according to player orientation
	sprite.flip_h = last_distance.x > 0
	
	if last_position.direction_to(position).length() > 0:
		
		if sprite.animation != "run":
			sprite.play("run")
		
		var trail_effect = TrailEffect.instantiate() as Node2D
		trail_effect.modulate = modulate
		get_parent().add_child(trail_effect)
		
		# animate trail -> it should move away from the player
		trail_effect.position = last_position + (distance * 0.25)
		var animate_trail_tween = create_tween()
		animate_trail_tween.tween_property(trail_effect, "position", last_position, 0.5)
		
		# animate sprite
		if animate_offset_tween:
			animate_offset_tween.stop()
		sprite.offset = -distance
		animate_offset_tween = create_tween()
		animate_offset_tween.tween_property(sprite, "offset", Vector2.ZERO, 0.05)
		last_distance = distance
	else:
		if sprite.animation != "default":
			sprite.play("default")
		
		
func mutate(other_color:MutagenColor) -> void:
	mutating = true
	self.mutagen_color = other_color
	modulate = mutagen_color.color
	AudioManager.play_sound(MUTATE_SOUND)
	sprite.play("mutate")
	sprite.animation_finished.connect(func():
		mutating = false
		mutated.emit(mutagen_color)
		)
	
	
func dissolve() -> void:
	sprite.animation = "dissolve"
	
	
func restore() -> void:
	sprite.animation = "restore"


func _on_input_throttle() -> void:
	movable = true
