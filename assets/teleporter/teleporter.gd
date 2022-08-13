extends Node2D


signal teleported


var count: int = 0


func _on_body_entered(body: Node2D):
	count += 1
	body.queue_free()
	if count == 2:
		emit_signal("teleported")
