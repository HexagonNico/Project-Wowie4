extends CenterContainer


export var level_1_scene: PackedScene


func play():
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(level_1_scene)


func quit():
	get_tree().quit()
