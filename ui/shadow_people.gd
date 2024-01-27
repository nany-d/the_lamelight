extends Node2D
var hiddenArray = []
var shownArray = []

func _ready():
	for number in range (6):
		shownArray.append(get_node("Shadow" + str(number + 1)))

func _showRandomShadow():
	if hiddenArray.size() > 0:
		var rnum = randi() % hiddenArray.size()
		hiddenArray[rnum].shadow_show()
		shownArray.append(hiddenArray[rnum])
		hiddenArray.remove_at(rnum)
		print(str(rnum) + " was shown")
	else:
		print("no shown shadows!")

func _hideRandomShadow():
	if shownArray.size() > 0:
		var rnum = randi() % shownArray.size() 
		shownArray[rnum].shadow_hide()
		hiddenArray.append(shownArray[rnum])
		shownArray.remove_at(rnum)
		print(str(rnum) + " was hidden")
	else:
		print("no hidden shadows!")


func _on_hide_button_pressed():
	_hideRandomShadow()
	pass # Replace with function body.


func _on_show_button_pressed():
	_showRandomShadow()
	pass # Replace with function body.
