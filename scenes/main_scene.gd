@tool # Run in editor.
extends Node2D
class_name MainScene

## Array of all locations, packed scenes.
@export var locations_unloaded: Array[PackedScene]

## Array of instantiated locations.
var locations: Array[Location] = []

## Reference to location button scene, to populate UI with options.
@export var location_button: PackedScene

## Reference to location title scene, to display when a location is loaded.
@export var location_title: PackedScene

## Location selector UI element, to add children to.
@export var location_selector: Control
# (I like adding references to UI like this, so if we move it around later it doesn't break the scripts.)

## Start screen UI element, will be hidden during game.
@export var start_screen: Sprite2D

## Texture to be used for instructions screen. Shown after start screen is clicked.
@export var instructions_texture: Texture

## Times clicked on start screen. 2 clicks start the game. (Will probably find a better way to do this later)
var start_clicks: int = 0

## Currently loaded location.
var current_location: Location

## Onready, show start screen and populate the UI.
func _ready() -> void:
	for location in locations_unloaded:
		locations.push_back(location.instantiate())
	for location in locations:
		var button: LocationButton = location_button.instantiate()
		button.location_to_load = location
		button.texture_normal = location.location_icon
		button.texture_focused = location.location_icon_selected
		location_selector.add_child(button)
	if not Engine.is_editor_hint(): # Don't hide things in editor.
		start_screen.show()
		location_selector.hide() # Prevent clicks on UI before game starts.
	else: # If in editor, show a random location instantly.
		show_location(locations.pick_random())

## Start game function. On first call, show insructions. On second call, hide start screen and load first location.
func start_game() -> void:
	start_clicks += 1
	if start_clicks == 1:
		start_screen.texture = instructions_texture
	elif start_clicks == 2:
		start_screen.hide()
		location_selector.show()
		show_location(locations[0])

## Load a new location, unloading the current one.
func show_location(new_location: Location) -> void:
	if current_location: # Shouldn't ever be false.
		remove_child(current_location)
	new_location.begin_fade_in()
	add_child(new_location)
	current_location = new_location
	if not Engine.is_editor_hint(): # Don't show title in editor.
		var title: LocationTitle = location_title.instantiate()
		title.set_text(new_location.location_name)
		add_child(title) # Will remove itself.

## Handle starting game clicks
func _on_start_screen_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_game()
