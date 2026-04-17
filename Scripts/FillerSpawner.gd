extends Node2D

var path = "res://Scenes/FillerScenes/"
var filler_resources = Array()

var current_filler

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
	
	spawn_filler(false)
	
	get_parent().Add_FillerSpawner(self)

func get_random_filler():
	filler_resources.shuffle()
	return filler_resources[0]

func spawn_filler(alert_parent = true):
	current_filler = get_random_filler().instance()
	call_deferred("add_child", current_filler)
	call_deferred("set_filler_position", current_filler, global_position)
	
	if (alert_parent):
		yield(wait(0.1), "completed")
		get_parent().Check_Cell_Space()

func wait(seconds):
	yield(get_tree().create_timer(seconds), "timeout")

func set_filler_position(filler, position):
	filler.global_position = position
