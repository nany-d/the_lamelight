extends Node2D

@onready var animplayer = $ShadowAnimPlayer

func _ready():
	animplayer.play("RESET")

func shadow_show():
	animplayer.play("shadow_show")

func shadow_hide():
	animplayer.play("shadow_hide")
