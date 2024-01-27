extends Node2D

# Spawn in correct option + 2 more incorrect from the JSON file
# if correct selected remove all, animations etc. happen then next joke new punchlines +comedy
# if incorrect remove all, animations etc. happen then next joke new punchlines, -comedy

# queuing jokes will be one of the next tasks so that the primary gameplay loops. Probably done using a timer and/or waiting for some animations to stop playing.

const PunchLine = preload("res://game/punch_line.tscn")

var comedy = GlobalSettings.comedy
var punch_number = GlobalSettings.punch_number
var loss_from_off_screen = 1

func spawn_punchlines():
	var correct_punch_chosen = false
	for i in range(punch_number):
		var p = PunchLine.instantiate()
		add_child(p)
		p.position += Vector2(300 * (i + 1), 0)
		if randi_range(i+1, punch_number) == punch_number and not correct_punch_chosen:
			p.set_punchline("Correct")
			p.set_correct(true)
			correct_punch_chosen = true
		else:
			p.set_punchline("Incorrect")
			p.set_correct(false)
		p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		p.visible_on_screen_notifier_2d.connect("screen_exited", fail_punch_line.bind(loss_from_off_screen))
			

func punch_line_check(punch_line):
	if (punch_line.is_correct):
		# Use punch number for reasons explained in fail_punch_line function
		comedy += punch_number
	else:
		comedy -= punch_number
	print(comedy)
	remove_punchlines()

# can vary how much a player loses for not selecting an option
func fail_punch_line(loss : int):
	# each fail punch line will -1 from comedy so if all 3 fall and are not clicked -3
	comedy -= 1
	print(comedy)
	remove_punchlines()

func remove_punchlines():
	for child in get_children():
		child.queue_free()
