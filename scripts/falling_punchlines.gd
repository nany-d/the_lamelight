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
@onready var comedian = $"../../GamePlaceholder/Comedian"
@onready var level_header = $"../LevelHeader"


var comedy = GlobalSettings.comedy
var punch_number = GlobalSettings.punch_number

# represents whether or not the show is still running
var show_in_progress = true

signal next_joke

# Comedy should be between max and min
const max_comedy = 18
const min_comedy = 0

var progress = 0

var miscount = 0

func _ready():
	GlobalSettings.set_show_in_progress(true)
	#print(comedian.animSprite.animation_finished)
	
func spawn_punchlines():
	level_header.text = "Act: " + str(GlobalSettings.level) + "/8"
	var correct_punch_chosen = false
	var false_array = [2, 3]	
	
	for i in range(punch_number):
		var p = PunchLine.instantiate()
		add_child(p)
		p.position += Vector2(((i + 1) * 400) - 250, 0)
		if randi_range(i+1, punch_number) == punch_number and not correct_punch_chosen:
			p.set_punchline("[center]"+joke.dialog[joke.joke_number - 1]["choice_1"]+"[/center]")
			p.set_correct(true)
			correct_punch_chosen = true
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		else:
			p.set_punchline("[center]"+joke.dialog[joke.joke_number - 1]["choice_" + str(false_array.pop_at(randi_range(0, (false_array.size() - 1))))]+"[/center]")
			p.set_correct(false)
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		p.visible_on_screen_notifier_2d.connect("screen_exited", fail_to_click)

	# Level management
	progress += 1
	if progress % 4 == 0:
		GlobalSettings.set_level(GlobalSettings.level + 1)
	if GlobalSettings.level >= 3 and randi_range(1, 4) == 3:
		spawn_censored_line()
	print(progress)
	print(GlobalSettings.level)


func spawn_censored_line():
	var c = CensorLine.instantiate()
	add_child(c)
	c.position = Vector2(randi_range(3, 10) * 100, 0)
	c.censored_button.connect("pressed", choose_censor)
	# also need to have comedian do the censored animation and play censored beep
	c.visible_on_screen_notifier_2d.connect("screen_exited", c.queue_free)
	

func fail_to_click():
	comedian.change_and_anim_sprite("embarrassed", 55)
	if comedy > 9:
		audio_manager.play_random_audience_cough()
	else:
		audio_manager.play_random_audience_disapproval()
	comedian.change_and_anim_sprite("embarrassed", 3)
	#await comedian.animSprite.animation_finished
	change_comedy(-1)
	miscount += 1
	if miscount >= 3:
		shadow_people._hideRandomShadow()
		miscount = 0
	remove_punchlines()

func punch_line_check(punch_line):
	if (punch_line.is_correct):
		change_comedy(punch_number)
		shadow_people._showRandomShadow()
		shadow_people._make_all_shadows_talk()
		punch_line.punch_line_text.modulate = Color(0, 1, 0)
		comedian.change_and_anim_sprite("happy", 55)
		audio_manager.play_random_clap_laugh()
		comedian.change_and_anim_sprite("happy", 3)
	else:
		change_comedy(-punch_number * GlobalSettings.level)
		comedian.change_and_anim_sprite("embarrassed", 55)
		for number in GlobalSettings.level:
			shadow_people._hideRandomShadow()
		shadow_people._make_random_shadow_talk()
		if comedy > 9 and randi_range(1,5) == 3:
			audio_manager.play_slow_clap()
			joke_delay.wait_time = 5
		else:
			audio_manager.play_random_audience_disapproval()
	set_result_line(punch_line)
	remove_punchlines()


func remove_punchlines():
	for child in get_children():
		child.queue_free()
	joke_delay.start()

func choose_censor():
	audio_manager.play_beep_censor()
	comedian.change_and_anim_sprite("censored", 5)
	remove_punchlines()
	for i in range(6):
		shadow_people._hideRandomShadow()
	change_comedy(-19)
	await comedian.animSprite.animation_finished

func change_comedy(amount : int):
	comedy += amount
	if comedy < min_comedy:
		print("You lose")
		failure()
		GlobalSettings.level = 1
	elif comedy > max_comedy:
		comedy = max_comedy
	if GlobalSettings.level == 9:
		print("You win")
		success()
		GlobalSettings.level = 1


func _on_joke_delay_timeout():
	if GlobalSettings.get_show_in_progress():
		emit_signal("next_joke")
		joke_delay.wait_time = 3.2


func set_result_line(punch_line):
	result_line.text = punch_line.punch_line_text.text
	if punch_line.is_correct:
		result_line.modulate = Color(0, 1, 0)
	else:
		result_line.modulate = Color(1, 0, 0)
	not_jakes_joke_delay.start()

func success():
	GlobalSettings.set_show_in_progress(false)
	await audio_manager.finished
	print("win sound")
	audio_manager.play_stage_win()
	comedian.change_and_anim_sprite("happy_success", 15)
	await audio_manager.finished
	curtains.curtains_close()
	
func failure():
	GlobalSettings.set_show_in_progress(false)
	await audio_manager.finished
	print("lose sound")
	audio_manager.play_stage_lose()
	comedian.change_and_anim_sprite("gameover", 15)
	await audio_manager.finished
	curtains.curtains_close()

func _on_not_jakes_joke_delay_timeout():
	result_line.clear()
