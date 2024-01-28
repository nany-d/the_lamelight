extends Node2D

@onready var censored_button = $CensoredButton
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

var has_been_clicked = false

func _ready():
	censored_button.connect("button_down", press_censor)

func _process(delta : float):
	# Move the potential punchlines down by 10 * the difficulty
	position += Vector2(0, 70 * delta * (1 + (GlobalSettings.level * 0.5)))

func press_censor():
	has_been_clicked = true
