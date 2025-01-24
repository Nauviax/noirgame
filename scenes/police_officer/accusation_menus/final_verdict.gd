class_name FinalVerdict

extends Control

func set_verdict(verdict: String):
	$Label.text = verdict


func _on_close_button_pressed() -> void:
	visible = false
