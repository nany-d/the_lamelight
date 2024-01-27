extends Node2D

@onready var animplayer = $ShadowAnimPlayer
@onready var audio_manager = $"/root/AudioEngine"

var original_position = Vector2()
var is_talking = false
var talk_time_elapsed = 0.0
var talk_duration = 3.0  # Duration of the talking animation in seconds
var amplitude = 50.0  # Amplitude of the sine wave motion
var phase_offset = 0.0  # Random phase offset for each shadow


func _ready():
	animplayer.play("RESET")
	original_position = position
	phase_offset = randf() * 2 * PI

func shadow_show():
	animplayer.play("shadow_show")

func shadow_hide():
	animplayer.play("shadow_hide")

# Make single shadow oscillate up and down to convey it's talking
func start_talking():
	is_talking = true
	talk_time_elapsed = 0.0

func stop_talking():
	is_talking = false
	position = original_position

func _process(delta):
	if is_talking:
		talk_time_elapsed += delta
		var y_offset = (sin(talk_time_elapsed * 2 * PI + phase_offset) + 1) * 0.5 * amplitude
		position.y = original_position.y - y_offset

		if talk_time_elapsed >= talk_duration:
			stop_talking()
