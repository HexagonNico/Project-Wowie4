extends Position2D


export var bullet_scene: PackedScene

onready var cooldown = $Cooldown
onready var shooting_sound = $ShootingSound


func shoot(direction: int = 1) -> Node:
	if cooldown.is_stopped():
		var bullet = bullet_scene.instance()
		bullet.global_position = global_position
		bullet.linear_velocity = Vector2(direction * 500.0, 0)
		bullet.set_as_toplevel(true)
		shooting_sound.play()
		cooldown.start()
		return bullet
	return null
