extends Area


func _ready():
	connect("body_entered", self, "on_body_entered")
	
func on_body_entered(body):
	if body.has_method("is_player"):
		if body.is_player():
			var parent : Node = get_parent()
			while parent != null:
				if parent.has_method("next_level"):
					parent.next_level()
					return
				parent = parent.get_parent()

