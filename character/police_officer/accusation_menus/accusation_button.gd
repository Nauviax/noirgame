class_name AccusationButton

extends Button


signal accused(name: String)


func _on_pressed() -> void:
	accused.emit(text)
