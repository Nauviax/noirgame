extends TextureButton
class_name LocationButton

## Scene to show when this button is clicked.
@export var location_to_load: Location

## Reference to mainscene script, to be called when clicked. (Bad practice maybe?)
@onready var main_scene: MainScene = get_node("/root/MainScene")

## Onclick, call the load_location function in the main scene.
func _on_pressed():
	main_scene.show_location(location_to_load)
