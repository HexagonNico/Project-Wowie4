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
var can_jump = true

onready var animation_player = $AnimationPlayer
onready var sprite = $RobotSprite
onready var edge_detector = [$EdgeDetectorLeft, $EdgeDetectorRight]
onready var ground_detector = $GroundDetector


func _process(delta: float):
	match current_state:
		IDLE:
			velocity = Vector2.ZERO
			animation_player.play("Idle")
		RUN:
			animation_player.play("Run")
			velocity.y += GRAVITY * delta
			sprite.scale.x = sign(velocity.x)
			if can_jump and not edge_detector[1 if velocity.x > 0.0 else 0].is_colliding() and ground_detector.is_colliding():
				velocity.y = -jump_strength
				current_state = AIR
		AIR:
			velocity.y += GRAVITY * delta
			animation_player.play("Jump" if velocity.y < 0.0 else "Falling")
			if ground_detector.is_colliding(): current_state = RUN


func _physics_process(_delta: float):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	if is_on_wall(): velocity.x *= -1


func reset(start_pos: Vector2):
	global_position = start_pos
	current_state = IDLE


func begin():
	if current_state == IDLE:
		current_state = RUN
		velocity.x = speed


func kick():
	var kick_ray = $RobotSprite/Kick
	if kick_ray.is_colliding():
		var collider = kick_ray.get_collider()
		if collider is RigidBody2D:
			collider.linear_velocity = Vector2(150.0, -200.0) * sprite.scale


func set_jump(value: bool):
	can_jump = value
