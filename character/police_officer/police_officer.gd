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
	
	if _selected_culprit == "Cory" and _selected_weapon == "Poison" and _selected_location == "Garden":
		# Exactly correct.
		_final_verdict_ui.set_verdict(2)
	elif _selected_culprit == "Alison" or (_selected_culprit == "Simon" and _selected_weapon == "Poison") or _selected_culprit == "Sarah" or (_selected_culprit == "Gordon" and _selected_weapon == "Sword") or (_selected_culprit == "Alvin" and _selected_weapon == "Dagger") or (_selected_culprit == "Jeffery" and _selected_weapon == "Tyre"):
		# Beleivable story, but wrong character.
		_final_verdict_ui.set_verdict(1)
	else:
		# Fail, either completely wrong, or slightly wrong.
		_final_verdict_ui.set_verdict(0)
	
	_final_verdict_ui.visible = true


func _on_accusation_menu_selection_cancelled() -> void:
	_levelSelectToolbar.visible = true
	_background.visible = false
