extends Node

signal coins_changed(new_count: int)
signal deaths_changed(new_count: int)

var level_start_coins: int = 0
var current_level_coins: int = 0
var total_coins: int:
	get:
		return level_start_coins + current_level_coins

var deaths: int = 0:
	set(value):
		deaths = value
		deaths_changed.emit(deaths)

var total_time: float = 0.0
var is_timer_running: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _process(delta: float) -> void:
	if is_timer_running:
		total_time += delta
func start_timer() -> void:
	is_timer_running = true

func stop_timer() -> void:
	is_timer_running = false

func get_formatted_time() -> String:
	var minutes: int = int(total_time) / 60
	var seconds: int = int(total_time) % 60
	var milliseconds: int = int((total_time - int(total_time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func add_coin():
	current_level_coins += 1
	coins_changed.emit(total_coins)

func add_death():
	deaths += 1

func save_level_progress() -> void:
	level_start_coins = total_coins
	current_level_coins = 0

func reset_current_level_coins() -> void:
	current_level_coins = 0
	coins_changed.emit(total_coins)

func reset_all_data() -> void:
	level_start_coins = 0
	current_level_coins = 0
	deaths = 0
	total_time = 0.0
	is_timer_running = false
	coins_changed.emit(total_coins)
	deaths_changed.emit(deaths)
