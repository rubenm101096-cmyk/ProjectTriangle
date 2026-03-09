extends Area2D

export(bool) var IsFlipped = false

onready var shape = $Shape

const TriangleChecker = preload("res://Scenes/TriangleChecker.tscn")

var filler_candidate = null
var cell_filled = false
var offset = Vector2(0, -12) #clean code

signal cell_filled
signal cell_emptied

func _ready():
	if IsFlipped:
		var triangleChecker = TriangleChecker.instance()
		var main = get_tree().current_scene
		main.call_deferred("add_child", triangleChecker)
		triangleChecker.global_position = global_position + offset

func _process(_delta):
	if filler_candidate != null and filler_candidate.owner.are_all_shapes_over():
		shape.color = Color.gray

func _on_Cell_area_entered(area):
	if not cell_filled and area.is_in_group("Filler"):
		filler_candidate = area
		filler_candidate.owner.check_shape_list(filler_candidate.get_name(), true)

func _on_Cell_area_exited(area):
	if not cell_filled and area.is_in_group("Filler"):
		area.owner.check_shape_list(area.get_name(), false)
		if area.owner.is_about_to_free():
			shape.color = Color.black
			cell_filled = true
			emit_signal("cell_filled", self)
		elif not area.owner.are_all_shapes_over():
			shape.color = Color.white

		filler_candidate = null

func empty_cell():
	shape.color = Color.white
	cell_filled = false
	filler_candidate = null
	emit_signal("cell_emptied", self)
