extends Button

func _ready() -> void:
	self.pressed.connect(out_program)
	
func out_program():
	get_tree().quit()
