extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if color_rect.material:
		color_rect.material.set_shader_parameter("factor", 0.0)

func change_scene_to_file(target_scene_path: String) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	await animate_transition(0.0, 1.0)
	
	get_tree().change_scene_to_file(target_scene_path)
	await get_tree().process_frame
	
	await animate_transition(1.0, 0.0)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene_to_packed(target_scene: PackedScene) -> void:
	if not target_scene:
		push_error("SceneTransition: Target scene is null!")
		return
		
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	await animate_transition(0.0, 1.0)
	
	get_tree().change_scene_to_packed(target_scene)
	await get_tree().process_frame
	
	await animate_transition(1.0, 0.0)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func animate_transition(from_val: float, to_val: float) -> void:
	if color_rect and color_rect.material:
		var mat = color_rect.material as ShaderMaterial
		mat.set_shader_parameter("node_resolution", get_viewport().get_visible_rect().size)
		mat.set_shader_parameter("factor", from_val)
		
		var tween = create_tween()
		tween.tween_property(mat, "shader_parameter/factor", to_val, 0.5)
		await tween.finished
