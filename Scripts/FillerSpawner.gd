extends Node2D

var path = "res://Scenes/FillerScenes/"
var filler_resources = Array()

func _ready():
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				var full_path = path + file_name
				filler_resources.append(load(full_path))
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	spawn_filler()

func get_random_filler():
	filler_resources.shuffle()
	return filler_resources[0]

func spawn_filler():
	var filler = get_random_filler().instance()
	call_deferred("add_child", filler)
	call_deferred("set_filler_position", filler, global_position)

func set_filler_position(filler, position):
	filler.global_position = position
