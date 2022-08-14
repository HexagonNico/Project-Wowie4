extends KinematicBody2D


signal player_destroyed


export var speed: float = 50.0
export var destroy_particles: PackedScene

var velocity = Vector2.ZERO

onready var edge_detector_left = $EdgeDetectorLeft
onready var edge_detector_right = $EdgeDetectorRight
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _ready():
	velocity.x = speed


func _physics_process(_delta: float):
	if not edge_detector_left.is_colliding():
		velocity.x = speed
	elif not edge_detector_right.is_colliding():
		velocity.x = -speed
	
	if is_on_wall():
		velocity.x *= -1
	
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	sprite.scale.x = 1 if velocity.x < 0.0 else -1
	
	animation_player.play("Walk")


func _on_destroy_area_body_entered(body: Node2D):
	if body is RigidBody2D:
		var particles: Particles2D = destroy_particles.instance()
		particles.emitting = true
		get_parent().add_child(particles)
		particles.position = body.position
		body.queue_free()
		emit_signal("player_destroyed")
