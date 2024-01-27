extends Node2D

# Spawn in correct option + 3 more incorrect from the JSON file
# if correct selected remove all, animations etc. happen then next joke new punchlines +comedy
# if incorrect remove all, animations etc. happen then next joke new punchlines, -comedy

const PunchLine = preload("res://game/punch_line.tscn")
const CensorLine = preload("res://game/censored_line.tscn")

@onready var joke = $"../Joke"
@onready var audio_manager = $"/root/AudioEngine"
@onready var joke_delay = $"../JokeDelay"
@onready var shadow_people = $"../../GamePlaceholder/ShadowPeople"
@onready var curtains = $"../../Curtains"
@onready var result_line = $"../ResultLine"
@onready var not_jakes_joke_delay = $"../NotJakesJokeDelay"


var comedy = GlobalSettings.comedy
var punch_number = GlobalSettings.punch_number
var difficulty = GlobalSettings.difficulty

# represents whether or not the show is still running
var show_in_progress = true

signal next_joke

# If comedy is more than max_comedy 3 times you win, if comedy is less than min_comedy 3 times you lose
const max_comedy = 18
const min_comedy = -18

var peak_comedy = 0
var lives = 1

func spawn_punchlines():
	var correct_punch_chosen = false
	var false_array = [2, 3]
	
	
	for i in range(punch_number):
		var p = PunchLine.instantiate()
		add_child(p)
		p.position += Vector2((i + 1) * 300, 0)
		if randi_range(i+1, punch_number) == punch_number and not correct_punch_chosen:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_1"])
			p.set_correct(true)
			correct_punch_chosen = true
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		else:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_" + str(false_array.pop_at(randi_range(0, (false_array.size() - 1))))])
			p.set_correct(false)
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		p.visible_on_screen_notifier_2d.connect("screen_exited", fail_to_click)
	if randi_range(difficulty, 100): # cant have difficulty more than 100
		spawn_censored_line()
			

func spawn_censored_line():
	var c = CensorLine.instantiate()
	add_child(c)
	c.position = Vector2(randi_range(3, 10) * 100, 0)
	c.censored_button.connect("pressed", choose_censor)
	# also need to have comedian do the censored animation and play censored beep
	c.visible_on_screen_notifier_2d.connect("screen_exited", c.queue_free)
	

func fail_to_click():
	if comedy > 0:
		audio_manager.play_random_audience_cough()
	else:
		audio_manager.play_random_audience_disapproval()
	change_comedy(-1)
	print(comedy)
	remove_punchlines()

func punch_line_check(punch_line):
	if (punch_line.is_correct):
		change_comedy(punch_number)
		shadow_people._showRandomShadow()
		punch_line.punch_line_text.modulate = Color(0, 1, 0)
		audio_manager.play_random_clap_laugh()
	else:
		change_comedy(-punch_number)
		shadow_people._hideRandomShadow()
		if comedy > 0 and randi_range(1,2) == 2:
			audio_manager.play_slow_clap()
			joke_delay.wait_time = 5
		else:
			audio_manager.play_random_audience_disapproval()
	print(comedy)
	set_result_line(punch_line)
	remove_punchlines()

func remove_punchlines():
	for child in get_children():
		child.queue_free()
	joke_delay.start()

func choose_censor():
	remove_punchlines()
	for i in range(6):
		shadow_people._hideRandomShadow()
	change_comedy(-18)

func change_comedy(amount : int):
	comedy += amount
	if comedy < min_comedy:
		lives -= 1
		comedy = min_comedy
	elif comedy > max_comedy:
		peak_comedy += 1
		comedy = max_comedy
	if lives <= 0:
		print("You lose")
		curtains.curtains_close()
		# switch to lose screen
	elif peak_comedy > 2:
		print("You win")
		curtains.curtains_close()
		# switch to win screen

func _on_joke_delay_timeout():
	emit_signal("next_joke")
	joke_delay.wait_time = 3.2


func set_result_line(punch_line):
	result_line.add_text(punch_line.punch_line_text.text)
	if punch_line.is_correct:
		result_line.modulate = Color(0, 1, 0)
	else:
		result_line.modulate = Color(1, 0, 0)
	not_jakes_joke_delay.start()


func _on_not_jakes_joke_delay_timeout():
	result_line.clear()
