extends MeshInstance

var plane1 = [
[-10, 10, 0],
[-10, -10, 0],
[-10, -10, 10],
[-10, 10, 10]
]

var plane2 = [
[-10, 10, 10],
[-10, 10, 0],
[20, 10, 0],
[15, 10, 10],
]

var plane3 = [
[15, -10, 10],
[20, -10, 0],
[20, 10, 0],
[15, 10, 10]
]

var plane4 = [
[15, -10, 10],
[20, -10, 0],
[-10, -10, 0],
[-10, -10, 10]
]

var plane5 = [
[15, -10, 10],
[-5, -5, 20],
[5, -5, 20],
[-10, -10, 10]
]

var plane6 = [
[-5, 5, 20],
[-5, -5, 20],
[-10, 10, 10],
[-10, -10, 10]
]

var plane7 = [
[-5, 5, 20],
[5, 5, 20],
[-10, 10, 10],
[15, 10, 10]
]

var plane8 = [
[5, -5, 20],
[5, 5, 20],
[15, -10, 10],
[15, 10, 10]
]

var plane9 = [
[5, -5, 20],
[5, 5, 20],
[-5, -5, 20],
[-5, 5, 20]
]

var plane10 = [
[20, 10, 0],
[20, -10, 0],
[-10, 10, 0],
[-10, -10, 0]
]

var walls = [
plane1,
plane2,
plane3,
plane4,
plane5,
plane6,
plane7,
plane8,
plane9,
plane10
]

var norms = [
Vector3(-1, 0, 0),
Vector3(0, -1, 0),
Vector3(0.894427, 0, 0.447214),
Vector3(0, 1, 0),
Vector3(0, 0.894427, -0.447214),
Vector3(0.894427, 0, -0.447214),
Vector3(0, 0.894427, 0.447214),
Vector3(-0.707107, 0, -0.707107),
Vector3(0, 0, 1),
Vector3(0, 0, -1)
]

var alphas = [
-10,
10,
-17.888546,
10,
13.416416,
13.41641,
-13.41641,
17.677675,
-20,
0
]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
