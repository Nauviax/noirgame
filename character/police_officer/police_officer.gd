extends Node2D


@export var _background : TextureRect
@export var _accusation_culprit_menu : AccusationMenu
@export var _accusation_weapon_menu : AccusationMenu
@export var _accusation_location_menu : AccusationMenu
@export var _final_verdict_ui : FinalVerdict

@onready var _levelSelectToolbar := get_tree().root.get_node("/root/MainScene/UI/LevelSelectToolbar")

var _selected_culprit : String
var _selected_weapon : String
var _selected_location : String


func _ready() -> void:
	pass


func _on_mouse_entered() -> void:
	print("Mouse entered")


func _on_mouse_exited() -> void:
	print("Mouse exited")


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not _background.visible:
		# TODO Maybe fade in
		_background.visible = true
		_levelSelectToolbar.visible = false
		_accusation_culprit_menu.visible = true


func _on_accusation_culprit_selected(option: String) -> void:
	_selected_culprit = option
	_accusation_weapon_menu.visible = true


func _on_accusation_weapon_selected(option: String) -> void:
	_selected_weapon = option
	_accusation_location_menu.visible = true


func _on_accusation_location_selected(option: String) -> void:
	_selected_location = option
	
	if _selected_culprit == "Alison" and _selected_weapon == "Bubble Blower" and _selected_location == "Garden":
		_final_verdict_ui.set_verdict(2)
	elif _selected_culprit in ["Alison", "Cory", "Jeffory", "Gordon"]: # TODO Select all the correct ones
		_final_verdict_ui.set_verdict(1)
	else:
		_final_verdict_ui.set_verdict(0)
	
	_final_verdict_ui.visible = true


func _on_accusation_menu_selection_cancelled() -> void:
		_levelSelectToolbar.visible = true
		_background.visible = false
