extends Node2D

onready var shape_list = $ShapeList
onready var animation_player = $ShapeList/AnimationPlayer

export(Array) var fill_identity

var shapes = Array()
var shapes_ready = Array()
var original_position

var about_to_free setget prepare_to_free, is_about_to_free
var spawn_index setget set_spawn_index

func _ready():
	if(fill_identity.size() > 4):
		fill_identity.resize(4)
	#trycatch amb size 2 o 3?
	
	original_position = global_position
	
	self.about_to_free = false
	for child in shape_list.get_children():
		if child is Area2D:
			shapes.append(child) 
			shapes_ready.append(false)

func _on_Dragger_is_being_dragged():
	if animation_player != null:
		animation_player.play("Extend")

func _on_Dragger_stopped_dragging():
	if are_all_shapes_over():
		var main = get_tree().current_scene
		self.about_to_free = true
	else:
		if animation_player != null:
			animation_player.play("Return")
		global_position = original_position #<------- move to original position

func check_shape_list(shape_name, add):
	var i = 0
	for shape in shapes:
		if shape.get_name() == shape_name:
			shapes_ready[i] = add
			break
		i += 1

func are_all_shapes_over():
	for over in shapes_ready:
		if not over:
			return false
	
	return true

func prepare_to_free(value):
	about_to_free = value
	if about_to_free:
		get_parent().spawn_filler() #<---- Clean Code !!!
		queue_free()

func is_about_to_free():
	return about_to_free

func set_spawn_index(value):
	spawn_index = value
