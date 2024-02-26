extends BaseMovementController

## in radians
@export var bullet_angle: float = 0:
	get:
		return bullet_angle
	set(value):
		sprite.rotate_z(bullet_angle)
		bullet_angle = value
		sprite.rotate_z(-(bullet_angle + PI))
@export var bullet_damage: int = 1
@export var faction_id: int = -1
@export var color: String
@export var lifetime: float = 1


@onready var sprite = %Sprite


func get_size_estimate() -> Vector2:
	return Vector2(.051 * 2.1, .051 * 2.1)


func _ready():
	match color:
		"red":
			$Sprite.animation = &"red"
		"blue":
			$Sprite.animation = &"blue"
		"yellow":
			$Sprite.animation = &"yellow"
		"green":
			$Sprite.animation = &"green"


func _get_desired_velocity() -> Vector2:
	return Vector2.from_angle(bullet_angle)


func _physics_process_collision(collision: KinematicCollision3D):
	var other = collision.get_collider() as Node3D
	if other == null:
		return
	var health_pool = other.get_node("HealthPool") as HealthPool
	var other_unit = other.get_node("Unit") as Unit
	if other_unit == null:
		return

	# this is going to be either the CharacterController3D of a thing or
	# it's going to be the StaticBody3D of the StageBoundary.

	# queue our destruction if we hit anything
	# TODO

	# queue health loss if what we hit has a health pool
	if health_pool != null and other_unit.faction_id != faction_id:
		health_pool.deal_damage(bullet_damage)
	
	# finally, delete ourselves
	queue_free()


func _physics_process_post(delta: float):
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
