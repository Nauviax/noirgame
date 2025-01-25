extends Node2D
class_name LocationTitle

## Animation parameters
var dist_from_top: float = 100
var spawn_x_offset: float = 100 # Offset from screen center.
var duration: float = 1 # Time between spawn and pause, then pause and exit.
var center_pause_delay: float = 2 # Time standing still in the center.

## Animation state. 0 = fade in, 1 = pause, 2 = fade out.
var state: int = 0

## Set label text, opacity to 0 and position to screen center.
func show_text(text: String) -> void:
	state = 0
	modulate.a = 0
	position = Vector2(get_viewport_rect().size.x / 2 + spawn_x_offset, dist_from_top)
	$Label.text = text
	show()

## Quick reset function to hide label when leaving scene too quickly.
func _exit_tree() -> void:
	hide()

## Travel across the screen right to left, fading in then out.
func _process(delta) -> void:
	match state:
		0:
			position.x -= spawn_x_offset * delta / duration
			modulate.a += delta / duration
			if modulate.a >= 1:
				state = 1
				modulate.a = 1
		1:
			center_pause_delay -= delta # Hacky, but avoids using a timer.
			if center_pause_delay <= 0:
				state = 2
		2:
			position.x -= spawn_x_offset * delta / duration
			modulate.a -= delta / duration
			if modulate.a <= 0:
				hide()

