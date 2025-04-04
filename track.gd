extends StaticBody3D

@onready var character = $Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_width() -> float:
	var raceway = $Raceway # measuring_track.get_node("Raceway")
	var start_divider = $StartDivider/MeshInstance3D # measuring_track.get_node("StartDivider/MeshInstance3D")
	var end_divider = $EndDivider/MeshInstance3D # measuring_track.get_node("EndDivider/MeshInstance3D")
	var w = raceway.mesh.size.x + start_divider.mesh.size.x + end_divider.mesh.size.x
	return w

func _on_stop_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.stop()
