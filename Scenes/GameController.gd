extends Node

enum GameState {
	Idle,
	Dragging,
	Winning,
	Checking,
	GameOver
}

var game_state
var score

var triangle_checkers_list = Array()
var filler_spawner_list = Array()

func _ready():
	game_state = GameState.Idle
	score = 0

#clean code !!
func Add_TriangleChecker(triangle_checker):
	triangle_checkers_list.append(triangle_checker)

func Add_FillerSpawner(filler_spawner):
	filler_spawner_list.append(filler_spawner)

func Check_Cell_Space():
	var any_filler = false
	for filler_spawner in filler_spawner_list:
		var any_space = false
		for triangle_checker in triangle_checkers_list:
			if triangle_checker.Check_Current_Space(filler_spawner.current_filler.fill_identity):
				any_space = true
				break
		
		if any_space:
			any_filler = true
			break
	
	if not any_filler:
		print_debug("game over")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
