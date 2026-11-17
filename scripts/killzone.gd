extends Area2D
@onready var death: AudioStreamPlayer2D = $Death
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	death.play()
	if body.has_method("die"):
		body.die()
	GameManager.add_death()
	GameManager.reset_current_level_coins()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
