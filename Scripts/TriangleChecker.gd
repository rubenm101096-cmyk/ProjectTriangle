extends Area2D

var triangles_location = Array() #Left, Up, Down, Right
var triangles_filled = Array()

func _ready():
	get_parent().Add_TriangleChecker(self)

func _on_TriangleArea_area_entered(area):
	if not triangles_location.has(area):
		area.connect("cell_filled", self, "_on_TriangleChecker_cell_filled")
		area.connect("cell_emptied", self, "_on_TriangleChecker_cell_emptied")
		triangles_location.append(area)
		triangles_filled.append(false)
		
		if triangles_location.size() == 4:
			triangles_location = _sort_triangles(triangles_location)

func _are_all_triangles_filled():
	for cell in triangles_filled:
		if cell == false:
			return false
	
	return true

func _on_TriangleChecker_cell_filled(cell):
	var index = triangles_location.find(cell)
	triangles_filled[index] = true
	
	if _are_all_triangles_filled():
		for cell in triangles_location:
			cell.empty_cell()

func _on_TriangleChecker_cell_emptied(cell):
	var index = triangles_location.find(cell)
	triangles_filled[index] = false

func _get_cell_position(cell):
	return Vector2(cell.global_position.x, cell.global_position.y)

func _print_sorted(seq):
	var sorted = Array()
	for cell in seq:
		sorted.append(_get_cell_position(cell))
	
	print_debug(sorted)

func _sort_triangles(seq):
	var n = len(seq)
	_print_sorted(seq)
	for i in range(n):
		var already_sorted = true
		for j in range(n - i - 1):
			var cell_a = _get_cell_position(seq[j])
			var cell_b = _get_cell_position(seq[j + 1])
			
			if cell_a > cell_b:
				var cell_aux = seq[j]
				seq[j] = seq[j + 1]
				seq[j + 1] = cell_aux
				
				already_sorted = false
		
		if already_sorted:
			break
	
	_print_sorted(seq)
	return seq

func Check_Current_Space(fill_identity):
	if fill_identity.size() == 1:
		#clean code please clean code!!!
		if fill_identity[0]: #upwards single triangle
			if triangles_filled[0] or triangles_filled[1] or triangles_filled[3]:
				return true
			else:
				return false
		else: #downwards single triangle
			if triangles_filled[2]:
				return true
			else:
				return false
	else:
		var i = 0 #check fill identity and triangles filled same size
		while i < fill_identity.size():
			if fill_identity[i] and triangles_filled[i]:
				return false
			i = i + 1
		return true
