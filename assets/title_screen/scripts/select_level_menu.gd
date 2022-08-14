extends CenterContainer


export(Array, PackedScene) var levels


func select_level(index: int):
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(levels[index])
