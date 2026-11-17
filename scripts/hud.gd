extends CanvasLayer
@onready var coins_label: Label = $MarginContainer/VBoxContainer/Coin/CoinsLabel
@onready var deaths_label: Label = $MarginContainer/VBoxContainer/Death/DeathsLabel
@onready var coin_icon: TextureRect = $MarginContainer/VBoxContainer/Coin/CoinIcon
@onready var death_icon: TextureRect = $MarginContainer/VBoxContainer/Death/DeathIcon
@onready var timer_label: Label = $MarginContainer/VBoxContainer/Timer/TimerLabel

func _ready() -> void:
	# Підписуємося на сигнали GameManager
	GameManager.coins_changed.connect(_on_coins_changed)
	GameManager.deaths_changed.connect(_on_deaths_changed)
	coin_icon.pivot_offset = coin_icon.size / 2.0
	death_icon.pivot_offset = coin_icon.size / 2.0
	# Встановлюємо початкові значення
	_on_coins_changed(GameManager.total_coins)
	_on_deaths_changed(GameManager.deaths)
	timer_label.text = GameManager.get_formatted_time()

func _process(_delta: float) -> void:
	timer_label.text = GameManager.get_formatted_time()

func _on_coins_changed(new_coins: int) -> void:
	coins_label.text = str(new_coins)
	animate_coin_pickup()

func _on_deaths_changed(new_deaths: int) -> void:
	deaths_label.text = str(new_deaths)
	animate_death()

func animate_coin_pickup() -> void:
	# Створюємо новий Tween
	var tween: Tween = create_tween()
	
	# Паралельно або послідовно анімуємо властивості:
	# 1. Збільшуємо іконку у 1.3 рази за 0.1 секунди з плавним згладжуванням
	tween.tween_property(coin_icon, "scale", Vector2(1.3, 1.3), 0.1)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
		
	# 2. Повертаємо іконку до нормального розміру (Vector2(1, 1)) за 0.15 секунди
	tween.tween_property(coin_icon, "scale", Vector2(1.0, 1.0), 0.15)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

func animate_death() -> void:
	var tween: Tween = create_tween()
	
	tween.tween_property(death_icon, "scale", Vector2(1.3, 1.3), 0.1)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
		
	tween.tween_property(death_icon, "scale", Vector2(1.0, 1.0), 0.15)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
