extends KinematicBody2D


enum {
	IDLE,
	RUN
}


const GRAVITY: float = 900.0

export var speed = 80.0

var current_state = IDLE

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var sprite = $RobotSprite


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


func _physics_process(_delta: float):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	if is_on_wall(): velocity.x *= -1
