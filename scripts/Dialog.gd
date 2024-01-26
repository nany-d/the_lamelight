extends Control

export var dialogPath = ""
export (float) var textSpeed = 0.05

onready var timer = $Timer
onready var character_name = $Name
onready var text = $Text
onready var portrait = $Portrait
onready var indicator = $Arrow
onready var indicatortext1 = $Arrow/RichTextLabel
onready var indicatortext2 = $Arrow/RichTextLabel2
onready var player = get_node("/root/World/YSort/Player")
onready var audio = $AudioStreamPlayer
onready var pauseMenu = get_node("/root/World/Hud/Control/PauseDialog")
onready var ui = get_node("/root/World/CanvasLayer/Popup")

var dialog

var phraseNum = 0
var finished = false
var count = 0

signal death_evasion

func _ready():
	timer.wait_time = textSpeed
	$Kimer.start()
	
func _process(_delta):
	indicator.visible = finished
	if Input.is_action_just_pressed("start") && count == 1:
		$Kimer2.start()
	if Input.is_action_just_pressed("attack") && visible == true:
		if finished:
			nextPhrase()
		else:
			text.visible_characters = len(text.text)
	if Input.is_action_just_pressed("drink") && (audio.playing == true || finished == true):
		player.state = player.states.MOVE
		get_tree().paused = false
		count = 0
		emit_signal("death_evasion")
		queue_free()

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")

	# Hellens angry dialog options
	if dialogPath == "res://json city/intro3.json":
		if TransitionMgr.HurtValue >= 9:
			dialogPath = "res://json city/intro3ANGRE.json"
	elif dialogPath == "res://json city/intro4.json":
		if TransitionMgr.HurtValue >= 10:
			dialogPath = "res://json city/intro4ANGRE.json"
	elif dialogPath == "res://json city/hellenGearface.json":
		if TransitionMgr.HurtValue >= 10:
			dialogPath = "res://json city/hellenGearfaceANGRE.json"
	
	# The Ending branching dialog options
	elif dialogPath == "res://json city/puppetress.json":
		if TransitionMgr.PlotValue >= 2:
			dialogPath = "res://json city/puppetressWellMet.json"
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	audio.playing = true
	player.state = player.states.IDLE
	$Kimer3.start()
	yield($Kimer3, "timeout")
	count = 1
	get_tree().paused = true
	if phraseNum > 0:
		indicatortext1.visible = false
		indicatortext2.visible = false
	if phraseNum >= len(dialog):
		player.state = player.states.MOVE
		get_tree().paused = false
		count = 0
		emit_signal("death_evasion")
		queue_free()
		return
		
	finished = false
	
	if dialog[phraseNum]["Name"] == "Hellen":
		character_name.bbcode_text = "Mavis"
	elif dialog[phraseNum]["Name"] == "The Puppeteer":
		if PlayerStats.level == "Green Vales":
			character_name.bbcode_text = "???"
		elif PlayerStats.level == "Yellow Tree Forest" || PlayerStats.level == "Blue Tundra":
			character_name.bbcode_text = "The Puppeteer?"
		else:
			character_name.bbcode_text = dialog[phraseNum]["Name"]
	else:
		character_name.bbcode_text = dialog[phraseNum]["Name"]
	text.bbcode_text = dialog[phraseNum]["Text"]
	
	text.visible_characters = 0
	
	var f = File.new()
	var img = dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	if img == "Hellenhappy.png":
		portrait.texture = hellenHappy
	elif img == "Hellenawkward.png":
		portrait.texture = hellenAwkward
	elif img == "Hellenconcerned.png":
		portrait.texture = hellenConcerned
	elif img == "Hellencoughing.png":
		portrait.texture = hellenCoughing
	elif img == "Hellendefault.png":
		portrait.texture = hellenDefault
	elif img == "Hellenhappy.png":
		portrait.texture = hellenHappy
	elif img == "Hellenhurt.png":
		portrait.texture = hellenHurt
	elif img == "Hellennervous.png":
		portrait.texture = hellenNervous
	elif img == "Hellenquestionable.png":
		portrait.texture = hellenQuestionable
	elif img == "Hellenscared.png":
		portrait.texture = hellenScared
	elif img == "Hellenshocked.png":
		portrait.texture = hellenShocked
	elif img == "Hellenshy.png":
		portrait.texture = hellenShy
	elif img == "Hellensweaty.png":
		portrait.texture = hellenSweaty
	elif img == "Hellenghost.png":
		portrait.texture = hellenGhost
	elif img == "Hellenhopeful.png":
		portrait.texture = hellenHopeful
	elif img == "Hellenconfused.png":
		portrait.texture = hellenConfused
	elif img == "Hellenpeaceful.png":
		portrait.texture = hellenPeaceful
	elif img == "Hellenmorose.png":
		portrait.texture = hellenMorose
	elif img == "Hellenmorose2.png":
		portrait.texture = hellenMorose2
	elif img == "Hellencrying.png":
		portrait.texture = hellenCrying
	elif img == "Hellenangry.png":
		portrait.texture = hellenAngry
	elif img == "Hellenangry2.png":
		portrait.texture = hellenAngry2
	elif img == "Hellenangry3.png":
		portrait.texture = hellenAngry3
	elif img == "Hellencrushed.png":
		portrait.texture = hellenCrushed
	elif img == "Hellenwinking.png":
		portrait.texture = hellenWinking
	elif img == "Hellendetermined.png":
		portrait.texture = hellenDetermined
	elif img == "Hellenlaughing.png":
		portrait.texture = hellenLaughing
	elif img == "Hellensmile.png":
		portrait.texture = hellenSmile
	elif img == "Hellenlaughingnohat.png":
		portrait.texture = hellenLaughingnohat
	elif img == "Hellenwnkingnohat.png":
		portrait.texture = hellenWinkingnohat
	elif img == "Hellenawkwardnohat.png":
		portrait.texture = hellenAwkwardnohat
	elif img == "Hellengearface.png":
		portrait.texture = hellenGearface
	elif img == "Hellengearfaceanxious.png":
		portrait.texture = hellenGearfaceanxious
	elif img == "Hellengearfaceangry.png":
		portrait.texture = hellenGearfaceangry
	elif img == "Hellengearfacesad.png":
		portrait.texture = hellenGearfacesad
	elif img == "Hellengearfacelesssad.png":
		portrait.texture = hellenGearfacelesssad
	elif img == "Hellengearfaceflinch.png":
		portrait.texture = hellenGearfaceflinch
	elif img == "Hellengearfacedetermined.png":
		portrait.texture = hellenGearfacedetermined
	elif img == "Hellengearfaceshock.png":
		portrait.texture = hellenGearfaceshock
	elif img == "Hellengearfacehopeful.png":
		portrait.texture = hellenGearfacehopeful
	elif img == "Hellengearfacehopeless.png":
		portrait.texture = hellenGearfacehopeless
	elif img == "Hellennoface.png":
		portrait.texture = hellenNoface
	elif img == "Hellennofaceanxious.png":
		portrait.texture = hellenNofaceanxious
	elif img == "Hellennofacenocase.png":
		portrait.texture = hellenNofacenocase
	elif img == "Hellennofaceangry.png":
		portrait.texture = hellenNofaceangry
	elif img == "The Puppeteerdefault.png":
		portrait.texture = puppetDefault
	elif img == "The Puppeteergrin.png":
		portrait.texture = puppetGrin
	elif img == "The Puppeteersad.png":
		portrait.texture = puppetSad
	elif img == "The Puppeteersadder.png":
		portrait.texture = puppetSadder
	elif img == "The Puppeteerragret.png":
		portrait.texture = puppetRagret
	elif img == "The Puppeteerragretcracked.png":
		portrait.texture = puppetRagretcracked
	elif img == "The Puppeteernohat.png":
		portrait.texture = puppetNohat
	elif img == "The Puppeteernohatlook.png":
		portrait.texture = puppetNohatlook
	else:
		portrait.texture = null
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
	
	audio.playing = false
	finished = true
	phraseNum += 1
	return

func _on_Kimer_timeout():
	dialog = getDialog()
	assert(dialog, "Dialog not found")

func _on_Kimer2_timeout():
	pauseMenu.visible = false
	ui.visible = true
