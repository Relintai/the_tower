extends Node

export(Array, PackedScene) var levels

var current_level_index : int = 0

var level : Node = null

func _enter_tree():
	level = levels[current_level_index].instance()
	add_child(level)
	
func next_level():
	call_deferred("next")
	
func next():
	level.queue_free()
	remove_child(level)
	current_level_index += 1
	
	if current_level_index >= levels.size():
		current_level_index = 0
	
	level = levels[current_level_index].instance()
	add_child(level)
	
func reload():
	call_deferred("reload_deferred")
	
func reload_deferred():
	level.queue_free()
	remove_child(level)
	level = levels[current_level_index].instance()
	add_child(level)
