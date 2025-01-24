extends TextureButton
class_name LocationButton

## PackedScene to load when this button is clicked.
@export var location_to_load: PackedScene

## Reference to mainscene script, to be called when clicked. (Bad practice maybe?)
@onready var main_scene: MainScene = get_node("/root/MainScene")

## Onclick, call the load_location function in the main scene.
func _on_pressed():
	main_scene.load_location(location_to_load)
