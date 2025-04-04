extends RigidBody3D

@export var racer_name: String

@export var speed: float = 1 
@export var trip_duration: float = 1.0

@export var trip_chance: float = 0.25
@export var trip_animation_speed = 0.6

@export var total_trips_possible = 4

var trip_count = 0
var can_advance = true
var timer_started = false
var trip_delayed = false

func _ready() -> void:
	$Timer.one_shot = true
	$TripTimerDelay.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Globals.racing:
		return
	
	if can_advance and not timer_started and not trip_delayed:
		_start_trip_timer()
	
	if can_advance:
		position -= Vector3(0.0, 0.0, delta * speed * randf_range(0.5, 1.0))
	else:
		rotate_y(PI * trip_animation_speed)

func _start_trip_timer():
	trip_delayed = true
	$TripTimerDelay.start()
	if trip_count <= total_trips_possible:
		if randf() < trip_chance:
			can_advance = false
			trip_count += 1
			timer_started = true
			$Timer.start(trip_duration)

func stop():
	speed = 0

func _on_timer_timeout() -> void:
	can_advance = true
	timer_started = false

func _on_trip_timer_delay_timeout() -> void:
	trip_delayed = false
