extends Control

@onready var speech_text = $RichTextLabel
@onready var bubble_icon = $TextureRect

func _ready():
	bubble_icon.connect("gui_input", _on_bubble_clicked)

func _on_bubble_clicked(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		speech_text.visible = !speech_text.visible
