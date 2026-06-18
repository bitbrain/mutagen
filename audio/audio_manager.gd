extends Node


const MUSIC_VOLUME_DB = -25


var music_stream_player:AudioStreamPlayer


func _ready() -> void:
	music_stream_player = AudioStreamPlayer.new()
	add_child(music_stream_player)


func play_music(audio_stream:AudioStream) -> void:
	music_stream_player.stream = audio_stream
	music_stream_player.volume_db = MUSIC_VOLUME_DB
	music_stream_player.play()
	
	
func play_sound(audio_stream:AudioStream, random_pitch = 0.2) -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = audio_stream
	sound.bus = &"SFX"
	add_child(sound)
	sound.pitch_scale = (1.0 - random_pitch / 2.0) + randf_range(0.0, random_pitch)
	sound.play()
	sound.finished.connect(func(): sound.queue_free())
	
