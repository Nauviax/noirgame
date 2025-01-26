extends Node2D

@onready var thought_bubble = $ThoughtBubble
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thought_bubble.visible = false


func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !thought_bubble.visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		thought_bubble.visible = true
		$BubbleSound.play()


func _on_click_area_mouse_exited() -> void:
	thought_bubble.visible = false
