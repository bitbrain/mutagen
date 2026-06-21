extends Node2D


const INTRO_STAGE_PATH = "res://scenes/intro_scene.tscn"
const GameplayMusic = preload("res://assets/virus.ogg")
const MENU_SOUND = preload("res://assets/menu.ogg")

@onready var play: Button = %Play
@onready var guide: Button = %Guide
@onready var quit: Button = %Quit


func _ready() -> void:
	AudioManager.play_music(GameplayMusic)
	play.pressed.connect(func(): 
		var transition_tween = create_tween()
		PlayerStats.start_stage_time()
		transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
		.finished.connect(get_tree().change_scene_to_file.bind(INTRO_STAGE_PATH))
	)
	guide.pressed.connect(VFX.guide)
	quit.pressed.connect(func(): get_tree().quit())
	
	play.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	play.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
