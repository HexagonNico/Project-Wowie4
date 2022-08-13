extends KinematicBody2D


enum {
	IDLE,
	RUN,
	AIR
}


const GRAVITY: float = 300.0

export var speed = 80.0
export var jump_strength = 200.0

var current_state = IDLE

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var sprite = $RobotSprite
onready var edge_detector_left = $EdgeDetectorLeft
onready var edge_detector_right = $EdgeDetectorRight


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if current_state == IDLE:
			current_state = RUN
			velocity.x = speed


func _process(delta: float):
	match current_state:
		IDLE:
			animation_player.play("Idle")
		RUN:
			animation_player.play("Run")
			velocity.y += GRAVITY * delta
			sprite.flip_h = velocity.x < 0.0
			if not edge_detector_left.is_colliding() or not edge_detector_right.is_colliding():
				velocity.y = -jump_strength
				current_state = AIR
		AIR:
			velocity.y += GRAVITY * delta
			animation_player.play("Jump" if velocity.y < 0.0 else "Falling")


func _physics_process(_delta: float):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	if is_on_wall(): velocity.x *= -1
