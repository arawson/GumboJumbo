extends BaseMovementController


var _facing: int = 0
@onready var _sprite = %Sprite


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
	# print ("Facing = %s" % _facing)
	match _facing:
		-1:
			_sprite.flip_h = 1
		+1:
			_sprite.flip_h = 0
	_facing = 0
