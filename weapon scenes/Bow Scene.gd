extends WeaponScene
class_name BowScene

@onready var bow_string = $String

var pull:= false

func start_attack():
	pull= true

func end_attack():
	pull= false
	bow_string.points[1].y= 0

func _physics_process(delta):
	if not pull: return
	
	if bow_string.points[1].y < 10:
		# Move the center point of the Bowstring Line2D
		# to make it look like it's pulled
		bow_string.points[1].y+= delta * 10
	else:
		pull= false
