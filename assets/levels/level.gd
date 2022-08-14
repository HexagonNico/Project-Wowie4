extends Node2D


export var next_level: PackedScene

onready var robot = $Robot
onready var bubble_wrap_ball = $BubbleWrapBall
onready var camera = $Camera
onready var animation_player = $AnimationPlayer


func _process(_delta: float):
	var robot_valid = is_instance_valid(robot)
	var bubble_wrap_ball_valid = is_instance_valid(bubble_wrap_ball)
	if robot_valid and bubble_wrap_ball_valid:
		if robot.global_position.distance_squared_to(bubble_wrap_ball.global_position) > 200 * 200:
			camera.global_position = robot.global_position
		else:
			camera.global_position = (robot.global_position + bubble_wrap_ball.global_position) / 2
	elif robot_valid:
		camera.global_position = robot.global_position
	elif bubble_wrap_ball_valid:
		camera.global_position = bubble_wrap_ball.global_position


func reset_level():
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func go_to_next_level():
	if next_level != null:
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(next_level)


func _on_reset_level_body_entered(_body: Node2D):
	animation_player.play("ResetLevel")
