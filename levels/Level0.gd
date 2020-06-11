extends VoxelWorldBlocky


func _unhandled_key_input(event : InputEventKey) -> void:
	if event.scancode == KEY_ENTER:
		get_parent().next_level()
