extends Control

onready var resolution_button = $MarginContainer/VBoxContainer/ResolutionButton

func _ready():
	resolution_button.add_item("1920x1080")
	resolution_button.add_item("1600x900")
	resolution_button.add_item("1280x720")

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_MuteCheckBox_toggled(button_pressed):
	var volume = 0 if button_pressed else AudioServer.get_bus_volume_db(0)
	AudioServer.set_bus_volume_db(0, volume)


func _on_ResolutionButton_item_selected(index):
	match index:
		0:
			OS.window_size = Vector2(1920, 1080)
		1:
			OS.window_size = Vector2(1600, 900)
		2:
			OS.window_size = Vector2(1280, 720)
