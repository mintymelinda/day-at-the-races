extends Node3D

var track_scene = preload("res://track.tscn")
@export var racers: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group("player"):
			racers.append(child)

	var width = track_scene.instantiate().get_width()
	_resize_finish_line(width)
	_place_tracks(width)


	
func _resize_finish_line(track_width):
	var start_pole = $FinishLine/StartPole
	var end_pole = $FinishLine/EndPole
	var tape = $FinishLine/Tape
	var finish = $FinishLine/Finish
	
	var full_width = track_width * racers.size()
	end_pole.position = start_pole.position + Vector3(full_width - end_pole.mesh.top_radius * 2, 0, 0)
	
	tape.mesh.size.x = full_width - end_pole.mesh.top_radius * 2
	tape.position.x = start_pole.position.x + tape.mesh.size.x / 2
	
	finish.mesh.size.x = full_width - end_pole.mesh.top_radius * 2
	finish.position.x = start_pole.position.x + finish.mesh.size.x / 2
	
func _place_tracks(track_width):
	var index = 0
	for racer in racers:
		var track = track_scene.instantiate()
		add_child(track)
		track.character.racer_name = racer
		track.position = Vector3(track_width * index , 0, 0)
		index += 1
