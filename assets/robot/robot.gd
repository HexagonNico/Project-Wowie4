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
onready var edge_detector = [$EdgeDetectorLeft, $EdgeDetectorRight]
onready var ground_detector = $GroundDetector


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if current_state == IDLE:
			current_state = RUN
			velocity.x = speed
		elif current_state == RUN and event.is_pressed():
			kick()


func _process(delta: float):
	match current_state:
		IDLE:
			animation_player.play("Idle")
		RUN:
			animation_player.play("Run")
			velocity.y += GRAVITY * delta
			sprite.scale.x = sign(velocity.x)
			if not edge_detector[1 if velocity.x > 0.0 else 0].is_colliding():
				velocity.y = -jump_strength
				current_state = AIR
		AIR:
			velocity.y += GRAVITY * delta
			animation_player.play("Jump" if velocity.y < 0.0 else "Falling")
			if ground_detector.is_colliding(): current_state = RUN


func _physics_process(_delta: float):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	if is_on_wall(): velocity.x *= -1


func kick():
	var kick_ray = $RobotSprite/Kick
	if kick_ray.is_colliding():
		var collider = kick_ray.get_collider()
		if collider is RigidBody2D:
			collider.linear_velocity = Vector2(100.0, -250.0) * sprite.scale
