extends Node

var mass = 10

var position = Vector3(-15.0, 5.0, 15.0)

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.translation = position

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _input(event):
	if event.is_action_pressed("ui_left"): position += Vector3(-1.0, 0.0, 0.0)
	if event.is_action_pressed("ui_right"): position += Vector3(1.0, 0.0, 0.0)
	if event.is_action_pressed("ui_up"): position += Vector3(0.0, 1.0, 0.0)
	if event.is_action_pressed("ui_down"): position += Vector3(0.0, -1.0, 0.0)
	self.translation = position