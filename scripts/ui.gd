extends Control

@onready var joke = $Joke
@onready var falling_punchlines = $FallingPunchlines
@onready var audio_engine = get_node("../AudioEngine")

# Called when the node enters the scene tree for the first time.
func _ready():
	joke.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	audio_engine.play_random_mumble_joke()
	falling_punchlines.spawn_punchlines()
	joke.visible = true
	joke.next_phrase()
