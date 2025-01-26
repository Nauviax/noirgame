extends Node2D

@onready var speech_bubble = $SpeechBubble
@onready var speech_bubble_label = $SpeechBubble/Label
@onready var thought_bubble = $ThoughtBubble
@onready var thought_bubble_label = $ThoughtBubble/Label
@onready var thought_bubble_timer = $ThoughtBubbleTimer
@onready var click_area = $ClickArea
@onready var animation_player = $AnimationPlayer

## First line is the speech dialog, the rest are thought dialogs. Two new lines seperate each dialog.
@export_multiline var all_lines: String = "speech1\n\nthought1\n\nthought2"
var thought_dialogs: Array[String]

var current_dialog_index = 0
var thought_dialogs_length: int
@onready var thought_bubble_timer_wait_time = thought_bubble_timer.wait_time
	
func _ready():
	speech_bubble.visible = false
	thought_bubble.visible = false
	# Randomize a delay between 0 and 5 seconds
	var random_delay = randf_range(2, 5)
	thought_bubble_timer.start(random_delay)

	## Split the string into an array of strings
	thought_dialogs.assign(all_lines.split("\n\n"))
	speech_bubble_label.text = thought_dialogs.pop_front() # First element is the speech dialog
	
	thought_bubble.modulate = Color(1, 1, 1, 0)
	thought_dialogs_length = len(thought_dialogs)
	if (thought_dialogs_length > 0):
		thought_bubble_label.text = thought_dialogs[current_dialog_index]
		current_dialog_index += 1
	
func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !speech_bubble.visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		thought_bubble.visible = false
		thought_bubble_timer.stop()
		speech_bubble.visible = true
		$ClickSound.play()


func _on_click_area_mouse_exited() -> void:
	if (speech_bubble.visible):
		speech_bubble.visible = false
		thought_bubble_timer.start()


func _on_thought_bubble_timer_timeout() -> void:
	thought_bubble_timer.wait_time = thought_bubble_timer_wait_time
	if (thought_bubble.visible):
		hide_thought_bubble()
	else:
		show_thought_bubble()
	
func show_thought_bubble():
	# Make sure the bubble is visible before playing the animation
	thought_bubble.visible = true
	animation_player.play("fade_in_slide_up")
	animation_player.connect("animation_finished", _on_fade_in_finished)
	$BubbleSound.play()
	
func _on_fade_in_finished(anim_name):
	if anim_name == "fade_in_slide_up":
		thought_bubble.modulate = Color(1, 1, 1, 1)
	animation_player.disconnect("animation_finished", _on_fade_in_finished)
		

func hide_thought_bubble():
	animation_player.play("fade_out_slide_up")
	animation_player.connect("animation_finished", _on_fade_out_finished)


func _on_fade_out_finished(anim_name):
	if anim_name == "fade_out_slide_up":
		switch_thought_bubble_text()
		thought_bubble.visible = false
		thought_bubble.modulate = Color(1, 1, 1, 0)
		animation_player.disconnect("animation_finished", _on_fade_out_finished)


func switch_thought_bubble_text():
	if (current_dialog_index == thought_dialogs_length):
		current_dialog_index = 0
	thought_bubble_label.text = thought_dialogs[current_dialog_index]
	current_dialog_index += 1
