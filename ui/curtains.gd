extends Control

@onready var animplayer = $CurtainsAnimPlayer
@onready var audio_manager = $"/root/AudioEngine"

func _ready():
	audio_manager.play_stage_intro()
	print("Playing")
	animplayer.play("RESET")

func curtains_open():
	animplayer.play("curtains_open")

func curtains_close():
	animplayer.play("curtains_close")
