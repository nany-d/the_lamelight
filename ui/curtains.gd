extends Control

@onready var animplayer = $CurtainsAnimPlayer
@onready var audio_manager = $"/root/AudioEngine"

func _ready():
	audio_manager.play_stage_intro()
	print("Playing")
