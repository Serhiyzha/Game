extends Control
@onready var coins: Label = $CenterContainer/VBoxContainer/Coins
@onready var deaths: Label = $CenterContainer/VBoxContainer/Deaths
@onready var timer: Label = $CenterContainer/VBoxContainer/Timer
@onready var main_menu: Button = $CenterContainer/VBoxContainer/MainMenu
@onready var click_sound: AudioStreamPlayer2D = $ClickSound
@export_file("*.tscn") var next_level_path: String

func _ready() -> void:
	coins.text = "Out of 33 coins you get: %d" % GameManager.total_coins
	deaths.text = "Deaths: %d" % GameManager.deaths
	timer.text = "Total time: " + GameManager.get_formatted_time()

func _on_main_menu_button_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	SceneTransition.change_scene_to_file(next_level_path)
