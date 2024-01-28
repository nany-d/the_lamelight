extends Node


@export var comedy = 18 : set = set_comedy
@export var punch_number = 3 : set = set_punch_number
@export var level = 1 : set = set_level
@export var show_in_progress = true : set = set_show_in_progress, get  = get_show_in_progress

func set_comedy(value):
	comedy = value


func set_punch_number(value):
	punch_number = value


func set_level(value):
	level = value
	
func set_show_in_progress(value):
	show_in_progress = value
	
func get_show_in_progress():
	return show_in_progress
