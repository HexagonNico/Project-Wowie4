extends Node2D


onready var animation_player = $AnimationPlayer


func reset_level():
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_reset_level_body_entered(_body: Node2D):
	animation_player.play("ResetLevel")
