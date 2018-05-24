extends Node

var position
var velocity          = Vector3( 0.0, 0.0, 0.0 )
var previous_position = Vector3( 0.0, 0.0, 0.0 )
var gravity           = Vector3( 0.0, 0.0, 0.0 )
var radius = 0.1

var mass      = 1.0
var mu        = 1.0 # 1./mass

var is_static = false
onready var point = $"point"
onready var arrow = $"point/arrow"
onready var arrowhead  = $"point/arrowhead"
onready var meshInstance = $"../../Rattle/MeshInstance"
onready var mass2 = $"../../Mass/MeshInstance"
onready var rattleSound = $"../../RattleSound"
var up = Vector3(0.0,1.0,0.0)

func _ready():
	
	# setting positions
	previous_position = position - velocity * get_physics_process_delta_time()
	point.global_translate(position)
	
	# setting color
	var mat = SpatialMaterial.new()
	mat.albedo_color = Color(randf(),randf(),randf())
	mat.set_metallic(0.0)
	mat.set_specular(0.0)
	point.set_surface_material(0,mat)
	arrow.set_surface_material(0,mat)
	arrowhead.set_surface_material(0,mat)

func _physics_process(delta):
	var walls = meshInstance.walls
	var norms = meshInstance.norms
	var alphas = meshInstance.alphas
	var iter = 0
	var dist_array = []
	for wall in walls:
		var temp_dist = (norms[iter].dot(position) + alphas[iter]) / norms[iter].length()
		if abs(temp_dist) < radius:
			dist_array.push_back(iter)
		iter+=1
	if dist_array.size() > 0:
		var force2 = force(delta)
		for dist in dist_array:
			var temp_norm = norms[dist]
			var temp_velocity = self.velocity
			var temp_velocity_par = temp_norm.dot(temp_velocity) * temp_norm
			var temp_velocity_perp = temp_velocity - temp_velocity_par
			var next_velocity = -0.8*temp_velocity_par
			
			
			var R = Vector3(0.0, 0.0, 0.0) if temp_norm.dot(force2) > 0 else -temp_norm.dot(force2) * temp_norm
			
			var N = Vector3(0.0, 0.0, 0.0) if temp_norm.dot(force2) > 0 else temp_norm.dot(force2) * temp_norm

			var T = Vector3(0.0, 0.0, 0.0) if temp_velocity_perp.length() == 0 else -0.5 * N.length() * temp_velocity_perp.normalized()
			
			set_velocity(next_velocity + temp_velocity_perp)
			
			force2 += R
			force2 += T
			
		verlet(delta, force2)
		if self.velocity.length() > 2.2:
			rattleSound.play()
		
	else:
		verlet(delta)
		
func _process(delta):
	if !is_static:
		point.translation = position
		arrow.scale = Vector3(0.2,10.0*velocity.length(),0.2)
		arrow.translation = Vector3(0.0,10.0*velocity.length(),0.0)
		arrowhead.translation = Vector3(0.0,20.0*velocity.length(),0.0)
		var axis = up.cross(velocity.normalized())
		var angle = acos(up.dot(velocity.normalized()))
		if axis.length() > 1e-3:
			point.global_rotate(axis.normalized(),angle)
		up = velocity.normalized()

func set_velocity(v):
	velocity          = v
	previous_position = position - velocity * get_physics_process_delta_time()

func verlet(delta,f=force(delta)):
	var new_position  = 2 * position - previous_position + f * mu * pow( delta , 2.0 )
	previous_position = position
	position          = new_position
	velocity          = ( position - previous_position ) / delta
	
func force(delta):
	var distance = mass2.position - position
	if distance.length() != 0:
		gravity = (6.67*mass*mass2.mass)/(pow(distance.length(), 2)) * distance.normalized()
	else:
		gravity = Vector3(0.0, 0.0, 0.0)
	return gravity