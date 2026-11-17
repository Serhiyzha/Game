extends Area2D
@export_file("*.tscn") var next_level_path: String
@onready var switch_sound: AudioStreamPlayer = $SwitchSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if next_level_path != "res://scenes/Menu/summary_screen.tscn":
			switch_sound.play()
			GameManager.save_level_progress()
			SceneTransition.change_scene_to_file(next_level_path)
		else:
			switch_sound.play()
			GameManager.save_level_progress()
			GameManager.stop_timer()
			SceneTransition.change_scene_to_file(next_level_path)
