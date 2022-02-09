extends VoxelWorldBlocky

var time : float = 0

func _process(delta):
	time += delta
	
	if time > 3:
		if get_parent().has_method("next_level"):
			get_parent().next_level()
			
		set_process(false)
