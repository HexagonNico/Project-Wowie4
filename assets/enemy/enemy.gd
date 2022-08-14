extends KinematicBody2D


export var speed: float = 50.0

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
