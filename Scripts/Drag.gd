extends Area2D

export(Vector2) var offset = Vector2(0, -25)

var mouse_over = false
var dragging = false

signal is_being_dragged
signal stopped_dragging

func _process(_delta):
	var game_state = get_tree().current_scene.curr_state
	
	if mouse_over and not dragging and Input.is_action_just_pressed("left_click") and game_state == GameController.State.IDLE:
		dragging = true
		emit_signal("is_being_dragged")

	if (dragging and Input.is_action_just_released("left_click")):
		dragging = false
		emit_signal("stopped_dragging")

	if dragging:
		get_parent().global_position = get_global_mouse_position() + offset

func _on_Dragger_mouse_entered():
	mouse_over = true

func _on_Dragger_mouse_exited():
	mouse_over = false
