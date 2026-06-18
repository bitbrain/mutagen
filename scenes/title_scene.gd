extends Node2D


const Stage1 = preload("res://scenes/stages/stage_tutorial.tscn")
const GameplayMusic = preload("res://assets/soundtrack-gameplay.ogg")
const MENU_SOUND = preload("res://assets/menu.ogg")

@onready var play: Button = %Play
@onready var quit: Button = %Quit


func _ready() -> void:
	AudioManager.play_music(GameplayMusic)
	play.pressed.connect(func(): 
		var transition_tween = create_tween()
		transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
		.finished.connect(get_tree().change_scene_to_packed.bind(Stage1))
	)
	quit.pressed.connect(func(): get_tree().quit())
	
	play.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	play.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
