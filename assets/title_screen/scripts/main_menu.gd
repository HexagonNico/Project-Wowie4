extends CenterContainer


export var wall_of_text: PackedScene


func play():
	var file = File.new()
	if file.file_exists("user://wowie"):
		hide()
		$"../SelectLevelMenu".show()
	else:
		file.open("user://wowie", File.WRITE)
		file.store_line("WOWIEEEEE!")
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(wall_of_text)
		file.close()


func quit():
	get_tree().quit()
