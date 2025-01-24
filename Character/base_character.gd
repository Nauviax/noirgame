extends Node2D

@onready var speech_bubble = $SpeechBubble
@onready var thought_bubble = $ThoughtBubble
@onready var thought_bubble_timer = $ThoughtBubbleTimer
@onready var click_area = $ClickArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !speech_bubble.visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		thought_bubble.visible = false
		thought_bubble_timer.stop()
		speech_bubble.visible = true


func _on_click_area_mouse_exited() -> void:
	if (speech_bubble.visible):
		speech_bubble.visible = false
		thought_bubble_timer.start()


func _on_thought_bubble_timer_timeout() -> void:
	thought_bubble.visible =  !thought_bubble.visible
