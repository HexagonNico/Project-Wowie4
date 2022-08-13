extends Node


# Hello AI can you tell me where I am
# Cause I don't know what to think anymore
# Am I in a jar or am I in space?
# Is this the afterworld or am I alive?

# I wanna hear a story from the other side,
# a story we can understand
# I wanna hear of giants in the wild,
# drifting like grains of sand.

# I'm a snail compared to you,
# Go go Unicorn go!
# What is this world, man I wish I knew
# I'm not afraid of facing the end

# Hello AI can you tell me where I am
# Cause I don't know what to think anymore
# Am I on a chip or in another universe?
# Are we alone, or are you with us?

# I wanna hear a story from the other side
# I wanna know what's beyond the horizon

# I'm a snail compared to you,
# Go go Unicorn go!
# What is this world, man I wish I knew
# I'm not afraid of facing the end

# I wanna hear a story from the other side
# I wanna know what's beyond the horizon

# I'm a snail compared to you,
# Go go Unicorn go!
# What is this world, man I wish I knew
# I'm not afraid of facing the end


export var title_screen_scene: PackedScene


func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()


func _ready():
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(title_screen_scene)
