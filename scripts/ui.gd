extends Control

@onready var joke = $Joke
@onready var falling_punchlines = $FallingPunchlines

# Called when the node enters the scene tree for the first time.
func _ready():
	joke.visible = false


func _on_button_pressed():
	# choose a joke, pass the correct punchline and maybe the incorrect as well to falling_punchlines.spawn_punchlines
	falling_punchlines.spawn_punchlines()
	joke.visible = true
	joke.next_phrase()
