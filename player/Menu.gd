extends CenterContainer

func _ready():
	$Main/VBoxContainer/Resume.connect("pressed", self, "on_pressed")
	
func on_pressed():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
