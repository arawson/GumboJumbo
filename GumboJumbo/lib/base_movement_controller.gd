
class_name BaseMovementController
extends CharacterBody3D


@export var cylinder_radius: float
@export var speed_max: float


var _y_ref: Vector3
var _v_tangent: Vector3
var _v_input: Vector2
var _p_inward: Vector3


func _get_desired_velocity() -> Vector2:
	return Vector2.ZERO


func _physics_process_post(_delta: float):
	pass


func _physics_process_collision(_collision: KinematicCollision3D):
	pass


func _physics_process_pre_calc_helpers():
	_y_ref = Vector3(0, position.y, 0)
	_p_inward = (position - _y_ref).normalized()
	_v_input = _get_desired_velocity()
	_v_tangent = Vector3.ZERO

	_v_tangent = (position - _y_ref).normalized().cross(Vector3(0, 1, 0))


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
	var r_error = cylinder_radius - (_y_ref.distance_to(position))
	velocity = r_error * _p_inward
	# disregard this move and slide's collisions!
	move_and_slide()

	look_at(_y_ref)
