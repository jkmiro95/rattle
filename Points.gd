extends Node

var Nds = []  # węzły
var NUM = 20
var e = 0.8 # wsp. restytucji

var node_object = load("material_point.tscn")

func _ready():
	create_scene()

func _process(delta):
	pass

func _physics_process(delta):
	for i in range(Nds.size()):
		for j in range(i):
			var dist = (Nds[i].position - Nds[j].position)
			if(dist.length() < Nds[i].radius + Nds[j].radius):
				print("Collision of pts: ",i," and ",j)
				var n = dist.normalized()
				var vI = Nds[i].velocity
				var vJ = Nds[j].velocity
				var mI = Nds[i].mass
				var mJ = Nds[j].mass
				var vIn = vI.dot(n)
				var vJn = vJ.dot(n)
				var Jdmm = (e + 1)*(vJn-vIn)/(mI+mJ)
				Nds[i].velocity +=  Jdmm*mJ*n - vIn*n
				Nds[j].velocity += -Jdmm*mI*n - vJn*n
#				var velocity_par_i = n.dot(vI) * n
#				var velocity_par_j = n.dot(vJ) * n
#				var velocity_perp_i = vI - velocity_par_i
#				var velocity_perp_j = vJ - velocity_par_j
#				var new_velocity_i = (mI*velocity_par_i + mJ*velocity_par_j + 0.8*mJ*(velocity_par_j - velocity_par_i)) / (mI + mJ)
#				var new_velocity_j = (mI*velocity_par_i + mJ*velocity_par_j + 0.8*mI*(velocity_par_i - velocity_par_j)) / (mI + mJ)
#				Nds[i].velocity = new_velocity_i + velocity_perp_i
#				Nds[j].velocity = new_velocity_j + velocity_perp_j
func create_scene():
	# initialize points
	for i in range(NUM):
		var new_node  = node_object.instance()
		var r     = 3.5
		var phi   = 2*PI*randf()
		var theta = -0.5*PI + PI*randf()
		new_node.position = r*Vector3(cos(phi)*sin(theta),cos(theta),sin(phi)*sin(theta) + 3)
		Nds.push_back(new_node)
		add_child(new_node)