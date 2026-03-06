extends Area2D

var triangles = Array()
var trianglesFilled = Dictionary()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TriangleArea_area_entered(area):
	if not triangles.has(area):
		area.connect("cell_filled", self, "_on_TriangleChecker_cell_filled")
		area.connect("cell_emptied", self, "_on_TriangleChecker_cell_emptied")
		triangles.append(area)
		trianglesFilled[area] = false

func _are_all_triangles_filled():
	for cell in trianglesFilled.values():
		if cell == false:
			return false
	
	return true

func _on_TriangleChecker_cell_filled(cell):
	trianglesFilled[cell] = true
	
	if _are_all_triangles_filled():
		for cell in triangles:
			cell.empty_cell()

func _on_TriangleChecker_cell_emptied(cell):
	trianglesFilled[cell] = false
