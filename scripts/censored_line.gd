extends Node2D

@onready var censored_button = $CensoredButton
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

var has_been_clicked = false

var censor_move_speeds = [6,7,9,11]

var move_speed = 0

func _ready():
	censored_button.connect("button_down", press_censor)
	move_speed = censor_move_speeds[randi_range(0,censor_move_speeds.size()-1)] * 10 * (1 + (GlobalSettings.level * 0.5))

func _process(delta : float):
	# Speed of censored will be randomly more or less than the other options	
	position += Vector2(0, move_speed * delta)

func press_censor():
	has_been_clicked = true
