class_name BaseMovementController
extends CharacterBody3D


@export var speed_max: float
@export var unit: Unit


var _y_ref: Vector3
var _v_tangent: Vector3
var _v_input: Vector2
var _p_inward: Vector3


func get_size_estimate() -> Vector2:
	return Vector2(1, 1)


func _get_desired_velocity() -> Vector2:
	return Vector2.ZERO


func _physics_process_post(_delta: float):
	pass


func _physics_process_collision(_collision: KinematicCollision3D):
	pass


func _init_internal_vectors():
	_y_ref = Vector3(0, position.y, 0)
	_p_inward = (position - _y_ref).normalized()
	_v_tangent = Vector3.ZERO
	_v_tangent = (position - _y_ref).normalized().cross(Vector3(0, 1, 0))


func _physics_process_pre_calc_helpers():
	_init_internal_vectors()
	_v_input = _get_desired_velocity()


func _physics_process(_delta):
	_physics_process_pre_calc_helpers()

	velocity = _v_tangent * _v_input.x * speed_max \
		+ Vector3(0, 1, 0) * _v_input.y * speed_max

	# or I could cheat and move_and_slide twice, once for the motion
	# and again to push it back onto the cylinder
	if move_and_slide():
		for i in range(get_slide_collision_count()):
			_physics_process_collision(get_slide_collision(i))

	_physics_process_bind_to_cylinder()

	_physics_process_post(_delta)


func _physics_process_bind_to_cylinder():
	var r_error = MainConstants.cylinder_radius - (_y_ref.distance_to(position))
	velocity = r_error * _p_inward
	# disregard this move and slide's collisions!
	move_and_slide()

	look_at(_y_ref)


func displace(amount: Vector2):
	_init_internal_vectors()
	global_position.y += amount.y

	# but X has to be projected around the cylinder
	var theta_0 = atan2(global_position.z, -global_position.x) - PI/2
	var theta = -amount.x / ( 2*PI*MainConstants.cylinder_radius )
	print("theta_0 = %s      theta = %s" % [theta_0, theta])
	global_position.x = MainConstants.cylinder_radius * sin(theta + theta_0)
	global_position.z = MainConstants.cylinder_radius * cos(theta + theta_0)
	
