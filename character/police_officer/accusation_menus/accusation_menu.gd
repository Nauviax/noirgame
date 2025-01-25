class_name AccusationMenu

extends Control


signal option_selected(option: String)
signal selection_cancelled()


@export var optionTexts : Array[String]
@export var optionTextures : Array[Texture2D]

@export var accusationButton : PackedScene


func _ready() -> void:
	for i in range(len(optionTexts)):
		var text := optionTexts[i]
		var texture := optionTextures[i]
		var new_button : AccusationButton = accusationButton.instantiate()
		new_button.text = text
		new_button.icon = texture
		$HBoxContainer.add_child(new_button)
		new_button.accused.connect(_on_accusation_button_pressed)


func _on_cancel_button_pressed() -> void:
	selection_cancelled.emit()
	visible = false


func _on_accusation_button_pressed(option: String) -> void:
	option_selected.emit(option)
	visible = false
