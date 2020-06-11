extends Area


func _ready():
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")
	
func on_body_entered(body):
	if body.has_method("ladder_area_entered"):
		body.ladder_area_entered(self)


func on_body_exited(body):
	if body.has_method("ladder_area_exited"):
		body.ladder_area_exited(self)
