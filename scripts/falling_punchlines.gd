extends Node2D

# Spawn in correct option + 3 more incorrect from the JSON file
# if correct selected remove all, animations etc. happen then next joke new punchlines +comedy
# if incorrect remove all, animations etc. happen then next joke new punchlines, -comedy

const PunchLine = preload("res://game/punch_line.tscn")

@onready var joke = $"../Joke"

var comedy = GlobalSettings.comedy
var punch_number = GlobalSettings.punch_number

signal next_joke

func spawn_punchlines():
	var correct_punch_chosen = false
	var false_array = [2, 3]
	for i in range(punch_number):
		var p = PunchLine.instantiate()
		add_child(p)
		p.position += Vector2(300 + i * 180, 0)
		if randi_range(i+1, punch_number) == punch_number and not correct_punch_chosen:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_1"])
			p.set_correct(true)
			correct_punch_chosen = true
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		else:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_" + str(false_array.pop_at(randi_range(0, (false_array.size() - 1))))])
			p.set_correct(false)
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
			

func punch_line_check(punch_line):
	if (punch_line.is_correct):
		comedy += 1
	else:
		comedy -= 1
	print(comedy)
	remove_punchlines()

func remove_punchlines():
	for child in get_children():
		child.queue_free()
	emit_signal("next_joke")
