extends Button

@export var next_scene: PackedScene

func _ready() -> void:
	self.pressed.connect(switch_scene)
	
func switch_scene():
	if next_scene != null:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("ERROR: not found scene in variables")
