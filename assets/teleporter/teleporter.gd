extends Node2D


signal teleported


var ball_entered: bool = false


func _on_body_entered(body: Node2D):
	if not ball_entered and body is RigidBody2D:
		body.queue_free()
		ball_entered = true
	elif ball_entered and body is KinematicBody2D:
		body.queue_free()
		emit_signal("teleported")
