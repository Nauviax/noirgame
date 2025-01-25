extends Node2D


@export var _accusation_culprit_menu : AccusationMenu
@export var _accusation_weapon_menu : AccusationMenu
@export var _accusation_location_menu : AccusationMenu
@export var _final_verdict_ui : FinalVerdict

var _selected_culprit : int
var _selected_weapon : int
var _selected_location : int


func _ready() -> void:
	pass


func _on_mouse_entered() -> void:
	print("Mouse entered")


func _on_mouse_exited() -> void:
	print("Mouse exited")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_accusation_culprit_menu.visible = true


func _on_accusation_culprit_selected(option: int) -> void:
	_accusation_culprit_menu.visible = false
	_accusation_weapon_menu.visible = true


func _on_accusation_weapon_selected(option: int) -> void:
	_accusation_weapon_menu.visible = false
	_accusation_location_menu.visible = true


func _on_accusation_location_selected(option: int) -> void:
	_accusation_location_menu.visible = false
	
	if _selected_culprit == 0 and _selected_weapon == 2 and _selected_location == 1:
		_final_verdict_ui.set_verdict("You are right!")
	else:
		_final_verdict_ui.set_verdict("That does not seem right...")
	
	_final_verdict_ui.visible = true
