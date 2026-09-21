extends Node2D

onready var score_label = $HighScoreLabel

func _ready():
	var score = SaveAndLoad.load_highscore() 
	if score != null:
		score_label.text = "Best Score: " + str(score)
	else:
		score_label.text = ""

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_OptionsButton_pressed():
	pass # Replace with function body.

func _on_QuitButton_pressed():
	get_tree().quit()
