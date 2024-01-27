extends AudioStreamPlayer

var mumble_jokes_streams = []
var mumble_delivery_streams = []
var audience_disapproval_streams = []
var coughs_streams = []
var intro_clap_streams = []
var clap_laugh_streams = []
var laugh_streams = []
var slow_clap_streams = []

func _ready():
	randomize()
	mumble_jokes_streams.append(load("res://audio/mumble_joke_01.mp3"))
	mumble_jokes_streams.append(load("res://audio/mumble_joke_02.mp3"))
	mumble_jokes_streams.append(load("res://audio/mumble_joke_03.mp3"))
	mumble_jokes_streams.append(load("res://audio/mumble_joke_04.mp3"))
	mumble_jokes_streams.append(load("res://audio/mumble_joke_05.mp3"))
	
	mumble_delivery_streams.append(load("res://audio/mumble_delivery_01.mp3"))
	mumble_delivery_streams.append(load("res://audio/mumble_delivery_02.mp3"))
	mumble_delivery_streams.append(load("res://audio/mumble_delivery_03.mp3"))
	mumble_delivery_streams.append(load("res://audio/mumble_delivery_04.mp3"))
	mumble_delivery_streams.append(load("res://audio/mumble_delivery_05.mp3"))
	
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_01.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_02.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_03.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_04.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_05.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_06.mp3"))
	audience_disapproval_streams.append(load("res://audio/audience_disapproval_07.mp3"))
	
	coughs_streams.append(load("res://audio/cough_01.mp3"))
	coughs_streams.append(load("res://audio/cough_02.mp3"))
	coughs_streams.append(load("res://audio/cough_03.mp3"))
	coughs_streams.append(load("res://audio/cough_04.mp3"))
	coughs_streams.append(load("res://audio/cough_05.mp3"))
	coughs_streams.append(load("res://audio/cough_06.mp3"))
	coughs_streams.append(load("res://audio/cough_07.mp3"))
	
	intro_clap_streams.append(load("res://audio/clap_01.mp3"))
	intro_clap_streams.append(load("res://audio/clap_02.mp3"))
	
	clap_laugh_streams.append(load("res://audio/clap_laugh_01.mp3"))
	clap_laugh_streams.append(load("res://audio/clap_laugh_02.mp3"))
	clap_laugh_streams.append(load("res://audio/clap_laugh_03.mp3"))
	
	laugh_streams.append(load("res://audio/laugh_01.mp3"))
	laugh_streams.append(load("res://audio/laugh_02.mp3"))
	
	slow_clap_streams.append(load("res://audio/slow_clap_01.mp3"))
	slow_clap_streams.append(load("res://audio/slow_clap_02.mp3"))


func play_stage_intro():
	self.stream = load("res://audio/stage_intro.mp3")
	play()
	
func play_stage_win():
	self.stream = load("res://audio/stage_win.mp3")
	
func play_crowd_chatting():
	self.stream = load("res://audio/crowd_chatting.mp3")
	play()
	
func play_beep_censor():
	self.stream = load("res://audio/beep_censor.mp3")
	play()	

func play_random_mumble_joke():
	self.stream = mumble_jokes_streams[randi() % mumble_jokes_streams.size()]
	play()

func play_random_mumble_delivery():
	self.stream = mumble_delivery_streams[randi() % mumble_delivery_streams.size()]
	play()
	
func play_random_audience_disapproval():
	self.stream = audience_disapproval_streams[randi() % audience_disapproval_streams.size()]
	play()
	
func play_random_audience_cough():
	self.stream = coughs_streams[randi() % coughs_streams.size()]
	play()
	
func play_random_intro_clap():
	self.stream = intro_clap_streams[randi() % intro_clap_streams.size()]
	play()

func play_random_clap_laugh():
	self.stream = clap_laugh_streams[randi() % clap_laugh_streams.size()]
	play()
	
func play_random_laugh():
	self.stream = laugh_streams[randi() % laugh_streams.size()]
	play()
	
func play_slow_clap():
	self.stream = slow_clap_streams[randi() % slow_clap_streams.size()]
	play()
