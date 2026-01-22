extends Area2D

onready var shape = $Shape

var filler_candidate = null
var cell_filled = false

func _process(_delta):
	if filler_candidate != null and filler_candidate.get_parent().are_all_shapes_over():
		shape.color = Color.gray

func _on_Cell_area_entered(area):
	if not cell_filled:
		filler_candidate = area
		filler_candidate.get_parent().check_shape_list(filler_candidate.get_name(), true)

func _on_Cell_area_exited(area):
	if not cell_filled:
		area.get_parent().check_shape_list(area.get_name(), false)
		if area.get_parent().is_about_to_free():
			shape.color = Color.black
			cell_filled = true
		elif not area.get_parent().are_all_shapes_over():
			shape.color = Color.white

		filler_candidate = null
