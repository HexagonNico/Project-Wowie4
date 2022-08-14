extends Position2D


export var bullet_scene: PackedScene

onready var cooldown = $Cooldown


func shoot(direction: int = 1):
	if cooldown.is_stopped():
		var bullet = bullet_scene.instance()
		bullet.global_position = global_position
		bullet.linear_velocity = Vector2(direction * 500.0, 0)
		bullet.set_as_toplevel(true)
		add_child(bullet)
		#sound_shoot.play()
		cooldown.start()
