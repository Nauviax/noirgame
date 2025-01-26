class_name AccusationButton

extends Button


signal accused(name: String)


func set_texture(texture: Texture2D) -> void:
	icon = texture

func set_button_text(new_text: String) -> void:
	$Label.text = new_text


func _on_pressed() -> void:
	accused.emit(text)
