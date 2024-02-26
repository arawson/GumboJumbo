extends BaseMovementController


@export var attack_primary: Attack


var _facing: int = +1
@onready var _sprite = %Sprite
var _can_shoot: bool = true
@onready var _shoot_cooldown: Timer = %ShootCooldown


func _get_desired_velocity() -> Vector2:
	var v_input = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		v_input.x += 1
		_facing = -1
	if Input.is_action_pressed("move_right"):
		v_input.x -= 1
		_facing = 1
	if Input.is_action_pressed("move_up"):
		v_input.y += 1
	if Input.is_action_pressed("move_down"):
		v_input.y -= 1

	return v_input


func _physics_process_post(_delta: float):
	match _facing:
		-1:
			_sprite.flip_h = 1
		+1:
			_sprite.flip_h = 0
	
	# now why would I have reset facing?
	# _facing = 0

	if Input.is_action_pressed("shoot") && _can_shoot:
		_shoot_primary()


func _on_shoot_cooldown_timeout():
	_can_shoot = true


func _shoot_primary():
	var bullet = attack_primary.scene.instantiate() as BaseMovementController
	var bullet_size = bullet.get_size_estimate()

	bullet.faction_id = unit.faction_id
	bullet.color = attack_primary.color
	bullet.speed_max = attack_primary.speed_base
	bullet.bullet_damage = attack_primary.damage_base
	bullet.collision_layer = collision_layer
	bullet.collision_mask = collision_mask
	bullet.global_position = global_position

	get_parent().add_child(bullet)
	match _facing:
		-1:
			bullet.bullet_angle = 0
		+1:
			bullet.bullet_angle = PI
	bullet.displace(Vector2(10*-bullet_size.x * _facing, 0))

	_can_shoot = false
	_shoot_cooldown.wait_time = attack_primary.cooldown
	_shoot_cooldown.start()


func _on_health_pool_damage_received(_damage:int):
	pass # Replace with function body.


func _on_health_pool_health_depleted():
	pass # Replace with function body.
