extends Node2D
class_name Location

## Name of location, unique
@export var location_name: String = "Base Location"

## Images to use for selector button
@export var location_icon: Texture
@export var location_icon_selected: Texture

## Duration of fade in/out
var fade_duration: float = 1.0

## Animation state for location opacity
var fade_in: bool = false

## Function to modulate the location to be hidden, then fade in over time.
func begin_fade_in() -> void:
	fade_in = true
	modulate = Color(1, 1, 1, 0)

## On process, fade in the location. Fade out handled by mainscene.
func _process(delta: float) -> void:
	if fade_in:
		modulate.a += delta / fade_duration
		if modulate.a >= 1:
			modulate.a = 1
			fade_in = false

