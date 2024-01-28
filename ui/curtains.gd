extends Control

@onready var animplayer = $CurtainsAnimPlayer
@onready var audio_manager = $"/root/AudioEngine"
@onready var reload_scene_tree_timer = $ReloadSceneTreeTimer

func _ready():
	audio_manager.play_stage_intro()
	print("Playing")
	#animplayer.play("RESET")
	curtains_open()

func curtains_open():
	animplayer.play("curtains_open")

func curtains_close():
	reload_scene_tree_timer.start()

func reset_scene():
	if get_tree():
		get_tree().reload_current_scene()

func _on_reload_scene_tree_timer_timeout():
	animplayer.play("curtains_close")
	await animplayer.animation_finished
	reset_scene()
