@tool # Run in editor.
extends Node2D
class_name MainScene


@export_category("PackedScenes")

## Array of all locations, packed scenes.
@export var locations: Array[PackedScene]

## Reference to location button scene, to populate UI with options.
@export var location_button: PackedScene


@export_category("UI elements")

## Location selector UI element, to add children to.
@export var location_selector: Control
# (I like adding references to UI like this, so if we move it around later it doesn't break the scripts.)


## Currently loaded location.
var current_location: Location

## Onready, load the initial location and populate the UI.
func _ready():
	load_location(locations[0])
	for location in locations:
		var button: LocationButton = location_button.instantiate()
		button.location_to_load = location
		location_selector.add_child(button)


## Load a new location, unloading the current one.
func load_location(new_location: PackedScene):
	if current_location != null: # Shouldn't ever be false
		current_location.queue_free()
	current_location = new_location.instantiate()
	add_child(current_location)
