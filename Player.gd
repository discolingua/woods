extends KinematicBody2D

const ACCELERATION = 240
const MAX_SPEED = 90
const FRICTION = 200

var velocity = Vector2.ZERO


# onready var means there's less _ready() function needed
onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")

# delta is normally 1/60 (.0166667) at 60FPS
# removing delta slows gameplay with frame drop (might be good?) but
# completely changes the accelation / speed scale

func _physics_process(delta):

	# input vector
	var _i = Vector2.ZERO
	
	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# normalize vector fixes fast/distorted diagonals
	_i = _i.normalized()

	if _i != Vector2.ZERO:	
		
		# set the blend position on each animation in the tree to match
		# the input vector

		animTree.set("parameters/Idle/blend_position", _i)
		animTree.set("parameters/Run/blend_position", _i)
		
		# update the current animation
		animState.travel("Run")

		velocity = velocity.move_toward(_i * MAX_SPEED, ACCELERATION * delta)
	else:
		animState.travel("Idle")
		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# move_and_slide already has delta factored in from the physics engine
	velocity = move_and_slide(velocity)

		
