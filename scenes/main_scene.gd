@tool # Run in editor.
extends Node2D
class_name MainScene

## Currently loaded location.
var current_location: Location

## TEMP var holding a location to load.
@export var initial_location: PackedScene

## Onready, load the initial location.
func _ready():
	load_location(initial_location)


## Load a new location, unloading the current one.
func load_location(new_location: PackedScene):
	if current_location != null:
		current_location.queue_free()
	current_location = new_location.instantiate()
	add_child(current_location)
