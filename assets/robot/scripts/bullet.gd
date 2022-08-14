extends RigidBody2D



# Called when the node enters the scene tree for the first time
func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node2D):
	if body is KinematicBody2D:
		body.animation_player.play("Destroy")
