extends Control

@export var start_level: PackedScene 
@onready var play_button: TextureButton = $MarginContainer/VBoxContainer/PlayButton
@onready var settings_button: TextureButton = $MarginContainer/VBoxContainer/SettingsButton
@onready var credits_button: TextureButton = $MarginContainer/VBoxContainer/CreditsButton
@onready var quit_button: TextureButton = $MarginContainer/VBoxContainer/QuitButton
@onready var click_sound: AudioStreamPlayer2D = $ClickSound
@onready var settings_panel: PanelContainer = $SettingsPanel
@onready var fullscreen_check: CheckBox = $SettingsPanel/VBoxContainer/FullscreenCheck
var master_bus: int
var music_bus: int
var sfx_bus: int
const CREDITS_SCENE = preload("res://scenes/Menu/credits_screen.tscn")

func _ready() -> void:
	await get_tree().process_frame

	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	fullscreen_check.button_pressed = is_fullscreen
	master_bus = AudioServer.get_bus_index("Master")
	music_bus = AudioServer.get_bus_index("Music")
	sfx_bus = AudioServer.get_bus_index("SFX")
	$SettingsPanel/VBoxContainer/MasterVolume/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	$SettingsPanel/VBoxContainer/MusicVolume/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	$SettingsPanel/VBoxContainer/SFXVolume/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))

func _on_play_button_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	if start_level:
		GameManager.start_timer()
		SceneTransition.change_scene_to_packed(start_level)

func _on_quit_button_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	get_tree().quit()
	
func _on_settings_button_pressed() -> void:
	click_sound.play()
	settings_panel.show()

func _on_close_settings_pressed() -> void:
	click_sound.play()
	settings_panel.hide()
	
func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))


func _on_credits_button_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	var credits_instance = CREDITS_SCENE.instantiate()
	add_child(credits_instance)
