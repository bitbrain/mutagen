extends Node2D


const INTRO_STAGE_PATH = "res://scenes/intro_scene.tscn"
const GameplayMusic = preload("res://assets/virus.ogg")
const MENU_SOUND = preload("res://assets/menu.ogg")

@onready var play: Button = %Play
@onready var guide: Button = %Guide
@onready var leaderboard: Button = %Leaderboard
@onready var quit: Button = %Quit
@onready var leaderboard_ui: Panel = %LeaderboardUI


func _ready() -> void:
	play.material = play.material.duplicate()
	quit.material = quit.material.duplicate()
	leaderboard.material = leaderboard.material.duplicate()
	guide.material = guide.material.duplicate()
	AudioManager.play_music(GameplayMusic)
	play.pressed.connect(func(): 
		var transition_tween = create_tween()
		PlayerStats.start_stage_time()
		transition_tween.tween_property(VFX, "transition_amount", 0.0, 0.3)\
		.finished.connect(get_tree().change_scene_to_file.bind(INTRO_STAGE_PATH))
	)
	leaderboard.pressed.connect(leaderboard_ui.show_leaderboard)
	guide.pressed.connect(VFX.guide)
	quit.pressed.connect(func(): get_tree().quit())
	
	var original_warp_amplitude = play.material.get_shader_parameter("warp_amplitude")
	
	var make_button_crazy = func(button:Button, color:Color = Color.WHITE):
		var jiggle_tween = create_tween()
		var material = button.material as ShaderMaterial
		jiggle_tween.tween_property(material, "shader_parameter/warp_amplitude", 1.7, 0.25)
		var color_tween = create_tween()
		color_tween.tween_property(material, "shader_parameter/text_color", color, 0.25)
	var make_button_okay = func(button:Button):
		var make_okay_tween = create_tween()
		var material = button.material as ShaderMaterial
		make_okay_tween.tween_property(material, "shader_parameter/warp_amplitude",original_warp_amplitude, 0.5)
		var color_tween = create_tween()
		color_tween.tween_property(material, "shader_parameter/text_color", Color.WHITE, 0.25)
		
	play.mouse_entered.connect(make_button_crazy.bind(play, MutagenColor.MUTAGEN_GREEN_COLOR))
	play.mouse_exited.connect(make_button_okay.bind(play))
	quit.mouse_entered.connect(make_button_crazy.bind(quit, MutagenColor.MUTAGEN_RED_COLOR))
	quit.mouse_exited.connect(make_button_okay.bind(quit))
	guide.mouse_entered.connect(make_button_crazy.bind(guide, MutagenColor.MUTAGEN_GREEN_COLOR))
	guide.mouse_exited.connect(make_button_okay.bind(guide))
	leaderboard.mouse_entered.connect(make_button_crazy.bind(leaderboard, MutagenColor.MUTAGEN_BLUE_COLOR))
	leaderboard.mouse_exited.connect(make_button_okay.bind(leaderboard))
	
	play.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.mouse_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	play.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
	quit.focus_entered.connect(func(): AudioManager.play_sound(MENU_SOUND))
