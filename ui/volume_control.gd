extends Control

const CONFIG_KEY = "settings.volume"
const VOLUME_PERCENTAGE = "volume_percentage"

const VOLUME_FULL = preload("uid://c8thmilqwjc0q")
const VOLUME_MUTED = preload("uid://bvbbejhq6mslx")
const DEFAULT_OPACITY = 0.35


@onready var volume_toggle: TextureButton = %VolumeToggle
@onready var volume_slider: VSlider = %VolumeSlider
@onready var save_timer: Timer = %SaveTimer


func _ready() -> void:
	
	volume_slider.visible = false
	modulate.a = DEFAULT_OPACITY
	volume_toggle.mouse_entered.connect(func(): modulate.a = 1.0)
	volume_slider.mouse_entered.connect(func(): modulate.a = 1.0)
	volume_slider.mouse_exited.connect(func(): modulate.a = DEFAULT_OPACITY)
	volume_slider.value_changed.connect(_on_volume_changed)
	volume_toggle.mouse_entered.connect(_on_hovered)
	volume_slider.mouse_exited.connect(func(): volume_slider.visible = false)
	
	volume_toggle.pressed.connect(_on_toggled)
	
	volume_slider.value = PlayerStore.get_value(CONFIG_KEY, VOLUME_PERCENTAGE, 1.0)
	
	save_timer.timeout.connect(PlayerStore.save)
	

func _on_toggled() -> void:
	var muted = volume_slider.value == 0
	volume_slider.value = 1 if muted else 0


func _on_hovered() -> void:
	volume_slider.visible = not volume_slider.visible


func _on_volume_changed(value:float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(bus_index, value)
	var muted = volume_slider.value == 0
	volume_toggle.texture_normal = VOLUME_MUTED if muted else VOLUME_FULL
	PlayerStore.set_value(CONFIG_KEY, VOLUME_PERCENTAGE, volume_slider.value)
	save_timer.start()
