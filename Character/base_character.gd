extends Node2D

@onready var speech_bubble = $SpeechBubble
@onready var click_area = $ClickArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !speech_bubble.visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("make it visible")
		speech_bubble.visible = true


func _on_click_area_mouse_exited() -> void:
	speech_bubble.visible = false
