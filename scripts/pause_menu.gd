extends Control
@onready var settings_panel: PanelContainer = $SettingsPanel
@onready var margin_container: MarginContainer = $MarginContainer
@onready var click_sound: AudioStreamPlayer2D = $ClickSound
@onready var master_bus: int = AudioServer.get_bus_index("Master")
@onready var music_bus: int = AudioServer.get_bus_index("Music")
@onready var sfx_bus: int = AudioServer.get_bus_index("SFX")
@onready var fullscreen_check: CheckBox = $SettingsPanel/VBoxContainer/FullscreenCheck


func _ready() -> void:
	hide()
	if settings_panel:
		settings_panel.hide()
	$SettingsPanel/VBoxContainer/MasterVolume/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	$SettingsPanel/VBoxContainer/MusicVolume/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	$SettingsPanel/VBoxContainer/SFXVolume/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	fullscreen_check.button_pressed = is_fullscreen

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		click_sound.play()
		if settings_panel and settings_panel.visible:
			_on_close_settings_button_pressed()
		else:
			toggle_pause()

func toggle_pause() -> void:
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused
	
	if is_paused:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hide()

func _on_resume_button_pressed() -> void:
	click_sound.play()
	toggle_pause()

func _on_main_menu_button_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menu/main_menu.tscn")
	GameManager.reset_all_data()

func _on_quit_button_pressed() -> void:
	click_sound.play()
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	click_sound.play()
	margin_container.hide()
	settings_panel.show()

func _on_close_settings_button_pressed() -> void:
	click_sound.play()
	settings_panel.hide()
	margin_container.show()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))

func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
