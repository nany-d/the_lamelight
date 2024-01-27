extends Control

@onready var joke = $Joke

# Called when the node enters the scene tree for the first time.
func _ready():
	joke.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	joke.visible = true
	joke.next_phrase()
