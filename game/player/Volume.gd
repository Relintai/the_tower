extends HSlider

func _ready():
	connect("value_changed", self, "on_value_changed")

func on_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	
