extends RigidBody2D


onready var left_bounce_detector = $LeftBounceDetector
onready var right_bounce_detector = $RightBounceDetector


func _physics_process(_delta):
	left_bounce_detector.global_rotation = 0.0
	right_bounce_detector.global_rotation = 0.0
	if left_bounce_detector.is_colliding() or right_bounce_detector.is_colliding():
		linear_velocity.x *= -0.75
