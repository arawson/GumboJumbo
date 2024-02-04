
# A test of moving around the cylinder.
# This will turn into a regular enemy later.
extends CharacterBody3D


@export var cylinder_radius: float
@export var speed_max: float


# Movement
# Y behaves normally, since that is in the plane of the cylinder
# Cylinder is along X and Z, since we're using physics we need a restitution
# "force" to push the characters back onto the cylinder.
# (We're using character body 2D so we don't really need a "force" but just
# velocity to achieve this)
# The direction of the corrective motion is towards the Y axis


func _physics_process(_delta):
	var y_ref = Vector3(0, position.y, 0)
	var p_inward = (position - y_ref).normalized()
	var v_input = Vector2.ZERO
	var v_tangent = Vector3.ZERO

	if Input.is_action_pressed("move_left"):
		v_input.x += 1
	if Input.is_action_pressed("move_right"):
		v_input.x -= 1
	if Input.is_action_pressed("move_up"):
		v_input.y += 1
	if Input.is_action_pressed("move_down"):
		v_input.y -= 1

	# v_tangent is the axis of our left-right motion
	v_tangent = (position - y_ref).normalized().cross(Vector3(0, 1, 0))

	velocity = v_tangent * v_input.x * speed_max \
		+ Vector3(0, 1, 0) * v_input.y * speed_max

	# or I could cheat and move_and_slide twice, once for the motion
	# and again to push it back onto the cylinder
	if move_and_slide():
		# TODO check for collisions
		pass

	var r_error = cylinder_radius - (y_ref.distance_to(position))
	velocity = r_error * p_inward
	# disregard this move and slide's collisions!
	move_and_slide()
	
	look_at(y_ref)
