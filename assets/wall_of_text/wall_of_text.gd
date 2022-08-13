extends Node


export var level1: PackedScene


func go_to_level_1():
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(level1)
