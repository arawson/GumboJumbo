extends BaseMovementController

## in radians
@export var bullet_angle: float = 0
@export var bullet_speed: float = 0.1
@export var origin: Node3D
@export var bullet_damage: int = 1


func _get_desired_velocity() -> Vector2:
	return Vector2.from_angle(bullet_angle) * bullet_speed


func _physics_process_collision(collision: KinematicCollision3D):
	var other = collision.get_collider() as Node3D
	if other == null:
		return
	var health_pool = other.get_node("HealthPool") as HealthPool
	# this is going to be either the CharacterController3D of a thing or
	# it's going to be the StaticBody3D of the StageBoundary.

	# queue our destruction if we hit anything
	# TODO

	# queue health loss if what we hit has a health pool
	if health_pool != null and other != origin:
		health_pool.deal_damage(bullet_damage)


func _physics_process_post(_delta: float):
	pass
