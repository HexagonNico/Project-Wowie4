extends Control


signal skip_button_pressed


export(Vector2) var start_position = Vector2(0, -20)
export(Vector2) var end_position = Vector2.ZERO
export(float) var fade_in_duration = 0.3
export(float) var fade_out_duration = 0.2

onready var center_cont = $Background/Menu
onready var resume_button = $Background/Menu/MenuOptions/ResumeButton

onready var root = get_tree().get_root()
onready var scene_root = root.get_child(root.get_child_count() - 1)
onready var tween = $Tween


func _ready():
	hide()


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			open()
		else:
			close()


func close():
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, fade_out_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(center_cont, "rect_position", end_position, start_position, fade_out_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()


func open():
	show()
	resume_button.grab_focus()
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, fade_in_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(center_cont, "rect_position", start_position, end_position, fade_in_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()


func _on_resume_button_pressed():
	if not tween.is_active():
		get_tree().paused = false
		close()


func _on_skip_button_pressed():
	get_tree().paused = false
	emit_signal("skip_button_pressed")


func _on_quit_button_pressed():
	var tree = get_tree()
	tree.paused = false
	# warning-ignore:return_value_discarded
	tree.change_scene("res://assets/title_screen/title_screen.tscn")


func _on_tween_all_completed():
	if modulate.a < 0.5:
		hide()
