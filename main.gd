extends Node

var winner

func _ready():
	$UI/WinnerLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if not Globals.racing and not winner:
			Globals.racing = true
		elif not winner:
			return
		else:
			reset()
			pass

func reset():
	Globals.racing = false
	get_tree().reload_current_scene()

func _on_finish_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and not winner:
		winner = body
		$UI/WinnerLabel.text = "Winner: " + winner.racer_name
		$UI/WinnerLabel.show()

func _on_stop_area_body_entered(body: Node3D) -> void:
	Globals.racing = false
