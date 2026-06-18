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
	
	
func play_sound(audio_stream:AudioStream) -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = audio_stream
	sound.bus = "SFX"
	add_child(sound)
	sound.play()
	sound.finished.connect(func(): sound.queue_free())
	
