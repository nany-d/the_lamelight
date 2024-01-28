extends Control

@onready var joke = $Joke
@onready var falling_punchlines = $FallingPunchlines
@onready var audio_engine = get_node("../AudioEngine")
@onready var button = $"../Button"
@onready var title_delay = $TitleDelay
@onready var comedian = $"../GamePlaceholder/Comedian"
@onready var curtains = $"../Curtains"

# Called when the node enters the scene tree for the first time.
func _ready():
	joke.visible = false
	comedian.change_and_anim_sprite("idle", 55)
	falling_punchlines.next_joke.connect(play_next_joke)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	# choose a joke, pass the correct punchline and maybe the incorrect as well to falling_punchlines.spawn_punchlines
	
	button.queue_free()
	curtains.curtains_open()
	
	await curtains.animplayer.animation_finished

	
	joke.visible = true
	joke.next_phrase()


func _on_title_delay_timeout():
	button.queue_free()


func play_next_joke():
	joke.next_phrase()
