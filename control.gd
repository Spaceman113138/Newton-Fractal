extends PanelContainer


var numIterations: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("HBoxContainer/iterEdit").text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_iter_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		RenderingServer.global_shader_parameter_set("numIterations", new_text.to_int())
	


func _on_increase_pressed() -> void:
	numIterations += 1
	RenderingServer.global_shader_parameter_set("numIterations", numIterations)
	get_node("HBoxContainer/iterEdit").text = str(numIterations)


func _on_decrease_pressed() -> void:
	numIterations = clampi(numIterations - 1, 0, 9999)
	RenderingServer.global_shader_parameter_set("numIterations", numIterations)
	get_node("HBoxContainer/iterEdit").text = str(numIterations)
