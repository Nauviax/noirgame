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

## Start screen UI element, will be hidden during game.
@export var start_screen: Sprite2D

## Texture to be used for instructions screen. Shown after start screen is clicked.
@export var instructions_texture: Texture

## Times clicked on start screen. 2 clicks start the game. (Will probably find a better way to do this later)
var start_clicks: int = 0

## Currently loaded location.
var current_location: Location = null

## Next location to load. If not null, current frame will be faded out until new location is loaded.
var next_location: Location = null

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
	start_screen.show()
	location_selector.hide() # Prevent clicks on UI before game starts.

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
	if next_location:
		next_location.modulate.a = 1 # Instantly reset opacity, to fix bug when spam clicking.
	next_location = new_location

## On process, fade out current location if a new one is being loaded.
func _process(delta: float) -> void:
	if next_location: # Do nothing if no location is being loaded.
		if current_location == null or current_location.modulate.a <= 0: # If no location loaded, or current location faded out.
			if current_location != null: # WAY TO MANY IF STATEMENTS AAAA
				remove_child(current_location) # Stop showing
			next_location.begin_fade_in()
			add_child(next_location) # Begin showing
			current_location = next_location
			next_location = null # Reset for next time.
		else: # Current location is fading out.
			current_location.modulate.a -= delta / current_location.fade_duration
			

## Handle starting game clicks
func _on_start_screen_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_game()
