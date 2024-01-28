extends TextureRect

var flicker_timer = Timer.new()  # Create a new Timer instance
var is_flickering = false  # State to track flickering
var min_flicker_interval = .1  # Minimum time interval between flickers
var max_flicker_interval = .3  # Maximum time interval between flickers

func _ready():
	add_child(flicker_timer)
	flicker_timer.connect("timeout", _on_flicker_timer_timeout)
	start_flickering()

# Starts the flickering effect
func start_flickering():
	set_process(true)
	is_flickering = true
	set_next_flicker()

# Stops the flickering effect
func stop_flickering():
	set_process(false)
	is_flickering = false
	visible = true  # Ensure the light is visible when flickering stops

# Sets the timer for the next flicker
func set_next_flicker():
	flicker_timer.wait_time = randf_range(min_flicker_interval, max_flicker_interval)
	flicker_timer.start()

# Called when the flicker timer times out
func _on_flicker_timer_timeout():
	# Randomly decide whether to flicker this time (10% chance)
	var test = randf()
	print(test)
	if test < 0.05:
		visible = false  # Turn off the light
	else:
		visible = true  # Keep or turn on the light

	if is_flickering:
		set_next_flicker()  # Schedule the next potential flicker

