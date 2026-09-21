extends Node2D

func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_OptionsButton_pressed():
	pass # Replace with function body.


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
