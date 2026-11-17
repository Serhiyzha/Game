extends Control

@export_file("*.tscn") var main_menu_scene: String

var is_transitioning: bool = false

func _ready() -> void:
	if $AnimationPlayer.has_animation("blink"):
		$AnimationPlayer.play("blink")

func _input(event: InputEvent) -> void:
	if not is_transitioning and (event is InputEventKey or event is InputEventMouseButton):
		if event.pressed:
			start_game()

func start_game() -> void:
	is_transitioning = true
	get_tree().change_scene_to_file(main_menu_scene)
