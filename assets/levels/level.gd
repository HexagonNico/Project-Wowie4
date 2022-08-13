extends Node2D


export var next_level: PackedScene

onready var animation_player = $AnimationPlayer


func reset_level():
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func go_to_next_level():
	if next_level != null:
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(next_level)


func _on_reset_level_body_entered(_body: Node2D):
	animation_player.play("ResetLevel")
