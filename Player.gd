extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 5

func _physics_process(delta):
	var _i = Vector2.ZERO
	
	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if _i != Vector2.ZERO:
		velocity = _i
	else:
		velocity = Vector2.ZERO

	move_and_collide(velocity)

		
