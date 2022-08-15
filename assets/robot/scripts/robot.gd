extends KinematicBody2D


enum {
	IDLE,
	RUN,
	AIR,
	SHOOTING
}


const GRAVITY: float = 300.0

export var speed = 80.0
export var jump_strength = 200.0

var current_state = IDLE
var velocity = Vector2.ZERO
var can_jump = true
var can_shoot = false

onready var animation_player = $AnimationPlayer
onready var sprite = $RobotSprite
onready var edge_detector = [$EdgeDetectorLeft, $EdgeDetectorRight]
onready var ground_detector = $GroundDetector
onready var gun = $RobotSprite/Gun

onready var jump_sound = $JumpSound


func _process(delta: float):
	match current_state:
		IDLE:
			velocity = Vector2.ZERO
			animation_player.play("Idle")
		RUN:
			animation_player.play("Run")
			sprite.scale.x = sign(velocity.x)
			if can_jump and not edge_detector[1 if velocity.x > 0.0 else 0].is_colliding():
				jump_sound.play()
				velocity.y = -jump_strength
				current_state = AIR
			elif not edge_detector[0].is_colliding() and not edge_detector[1].is_colliding():
				current_state = AIR
			if can_shoot:
				current_state = SHOOTING
				var bullet = gun.shoot(sprite.scale.x)
				if bullet != null:
					get_parent().call_deferred("add_child", bullet)
		AIR:
			velocity.y += GRAVITY * delta
			animation_player.play("Jump" if velocity.y < 0.0 else "Falling")
			sprite.scale.x = sign(velocity.x)
			if ground_detector.is_colliding() and velocity.y > 0.0:
				current_state = RUN
		SHOOTING:
			velocity = Vector2.ZERO
			animation_player.play("Shoot")
			if gun.cooldown.is_stopped():
				current_state = RUN
				velocity.x = speed * sprite.scale.x


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
	else:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


func kick():
	var kick_ray = $RobotSprite/Kick
	if kick_ray.is_colliding():
		var collider = kick_ray.get_collider()
		if collider is RigidBody2D:
			collider.linear_velocity = Vector2(150.0, -150.0) * sprite.scale


func set_jump(value: bool):
	can_jump = value


func _on_enemy_detector_body_entered(_body: Node2D):
	can_shoot = true


func _on_enemy_detector_body_exited(_body: Node2D):
	can_shoot = false
