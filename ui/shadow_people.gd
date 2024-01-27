extends Node2D
var hiddenArray = []
var shownArray = []

func _ready():
	for number in range(6):
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

func _make_random_shadow_talk():
	if shownArray.size() > 0:
		var rnum = randi() % shownArray.size()
		shownArray[rnum].start_talking()
		print("Shadow " + str(rnum + 1) + " is talking")
	else:
		print("No shadows available to talk!")
		
func _make_all_shadows_talk():
	if shownArray.size() > 0:
		for shadow in shownArray:
			shadow.start_talking()
		print("All shadows are talking")
	else:
		print("No shadows available to talk!")