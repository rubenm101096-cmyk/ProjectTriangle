extends Node

onready var score_label = $ScoreLabel
onready var game_over = $Game_Over
onready var game_over_sound = $GameOverSound

enum State {IDLE, GAME_OVER}

var curr_state = State.IDLE

var score
var times_scored
var score_values = [5, 15, 50, 150]

var triangle_checkers_list = Array()
var filler_spawner_list = Array()

func _ready():
	score = 0
	times_scored = 0

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

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
		var highest_score = SaveAndLoad.load_highscore()
		if highest_score == null or highest_score < score: 
			SaveAndLoad.save_highscore(score)
		curr_state = State.GAME_OVER
		game_over.visible = true
		game_over_sound.play()

func Update_Score():
	times_scored += 1
	yield(wait(0.2), "completed")
	
	if (times_scored > 0):
		Update_Score_Value()

func Update_Score_Value():
	
	score += score_values[times_scored - 1]
	score_label.text = str(score)
	times_scored = 0

func wait(seconds):
	yield(get_tree().create_timer(seconds), "timeout")
