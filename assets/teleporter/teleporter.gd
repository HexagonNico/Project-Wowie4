extends Node2D


signal teleported


export var teleport_particles: PackedScene

var ball_entered: bool = false


func _on_body_entered(body: Node2D):
	if not ball_entered and body is RigidBody2D:
		var particles: Particles2D = teleport_particles.instance()
		particles.emitting = true
		get_parent().add_child(particles)
		particles.position = body.position
		body.queue_free()
		ball_entered = true
	elif ball_entered and body is KinematicBody2D:
		var particles: Particles2D = teleport_particles.instance()
		particles.emitting = true
		get_parent().add_child(particles)
		particles.position = body.position
		body.queue_free()
		$Timer.start()


func _on_timer_timeout():
	emit_signal("teleported")
