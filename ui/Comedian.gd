extends Node2D

@onready var animPlayer = get_node("ComedianAnimatedSprite/ComedianAnimPlayer")
@onready var animSprite = $ComedianAnimatedSprite
@onready var resetTimer = $ResetTimer
var animname = "idle"
signal change_sprite

func _on_change_sprite():
	animSprite.play(animname)

func change_and_anim_sprite(_animname, _waitforreset):
	resetTimer.stop()
	animname = _animname
	animPlayer.play("bounce")
	resetTimer.wait_time = _waitforreset
	resetTimer.start()

func _on_test_button_pressed():
	var arr = ["censored","embarrassed","gameover","happy","happy_success","joke","skull"]
	var i = randi() % 7
	change_and_anim_sprite(arr[i], 3)
	pass # Replace with function body.


func _on_reset_timer_timeout():
	animname = "idle"
	animPlayer.play("bounce")
	pass # Replace with function body.
