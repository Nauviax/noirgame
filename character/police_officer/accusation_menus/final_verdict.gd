class_name FinalVerdict

extends TextureRect


signal closed()


@export var _fail_background : Texture2D
@export var _mislead_background : Texture2D
@export var _good_background: Texture2D


func set_verdict(verdict: int):
	if verdict == 0:
		texture = _fail_background
	elif verdict == 1:
		texture = _mislead_background
	else:
		texture = _good_background


func _on_close_button_pressed() -> void:
	closed.emit()
	visible = false
