extends Node2D

onready var animationPlayer = $AnimationPlayer
var shapeList

var shapes = Array()
var shapesReady = Array()

var about_to_free setget prepare_to_free, is_about_to_free

func _ready():
	about_to_free = false
	for child in get_children():
		if child is Area2D:
			shapes.append(child)
			shapesReady.append(false)

func _on_Dragger_is_being_dragged():
	if animationPlayer != null:
		animationPlayer.play("Extend")

func _on_Dragger_stopped_dragging():
	if are_all_shapes_over():
		self.about_to_free = true
	elif animationPlayer != null:
		animationPlayer.play("Return")

func check_shape_list(shape_name, add):
	var i = 0
	for shape in shapes:
		if shape.get_name() == shape_name:
			shapesReady[i] = add
			break
		i += 1

func are_all_shapes_over():
	for over in shapesReady:
		if not over:
			return false

	return true

func prepare_to_free(value):
	about_to_free = value
	if about_to_free:
		get_parent().queue_free()

func is_about_to_free():
	return about_to_free
