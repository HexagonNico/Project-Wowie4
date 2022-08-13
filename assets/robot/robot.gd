extends KinematicBody2D


enum {
	IDLE,
	RUN
}


export var speed: float = 50.0

var current_state = IDLE

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var sprite = $RobotSprite


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if current_state == IDLE:
			current_state = RUN
			velocity.x = speed


func _process(_delta: float):
	match current_state:
		IDLE:
			animation_player.play("Idle")
		RUN:
			animation_player.play("Run")
			sprite.flip_h = velocity.x < 0.0


func _physics_process(_delta: float):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	if is_on_wall(): velocity.x *= -1
