@tool # Run in editor.
extends Node2D
class_name MainScene

## Array of all locations, packed scenes.
@export var locations_unloaded: Array[PackedScene]

## Array of instantiated locations.
var locations: Array[Location] = []

## Reference to location button scene, to populate UI with options.
@export var location_button: PackedScene

## Location selector UI element, to add children to.
@export var location_selector: Control
# (I like adding references to UI like this, so if we move it around later it doesn't break the scripts.)

## Currently loaded location.
var current_location: Location

## Onready, load the initial location and populate the UI.
func _ready():
	for location in locations_unloaded:
		locations.push_back(location.instantiate())
	show_location(locations[0])
	for location in locations:
		var button: LocationButton = location_button.instantiate()
		button.location_to_load = location
		button.texture_normal = location.location_icon
		button.texture_focused = location.location_icon_selected
		location_selector.add_child(button)

## Load a new location, unloading the current one.
func show_location(new_location: Location):
	if current_location: # Shouldn't ever be false.
		remove_child(current_location)
	current_location = new_location
	add_child(current_location)
