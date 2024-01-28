extends Node2D
class_name Punchline

@onready var punch_line_text = $PunchLineText
@onready var punch_line_button = $PunchLineButton
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D


var is_correct = false


# change so that off screen notifier to destroy (free) this node.
func _ready():
	position += Vector2(0, 100) #randi_range(0,20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float):
	# Move the potential punchlines down by 10 * the difficulty
	position += Vector2(0, 80 * delta * (1 + (GlobalSettings.level * 0.5)))
	#var printer = (100 * delta * GlobalSettings.level)
	#print(printer)

func set_punchline(new_text : String):
	punch_line_text.text = new_text
	
func set_correct(new_correctness : bool):
	is_correct = new_correctness
