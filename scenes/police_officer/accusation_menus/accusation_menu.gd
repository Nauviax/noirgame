class_name AccusationMenu

extends Control


signal option_selected(option: int)


@export var option1 : String
@export var option2 : String
@export var option3 : String


func _ready() -> void:
	$HBoxContainer/AccusationButton1.text = option1
	$HBoxContainer/AccusationButton2.text = option2
	$HBoxContainer/AccusationButton3.text = option3


func _on_cancel_button_pressed() -> void:
	visible = false


func _on_accusation_button_pressed(button_id: int) -> void:
	option_selected.emit(button_id)
