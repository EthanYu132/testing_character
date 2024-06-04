extends CharacterBody2D

# Constants
const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const DASH_SPEED = 2000
const DASH_DURATION = 0.1
const DASH_COOLDOWN = 1.0

# Variables
var dash_timer = 0.0
var dash_cooldown_timer = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	walk_run(delta) # walking and running mechanics
	dash(delta) # Dash mechanic
	jump(delta) # Handle jump.
	move_and_slide() #End

func dash(delta):
	if Input.is_action_just_pressed("dash"):
		var direction1 = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction1 * DASH_SPEED
	
func jump(delta):
	#regular jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#wall jump 
	if Input.is_action_just_pressed("ui_accept") and is_on_wall():
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.y = -300
		velocity.x = -1000 * direction

func walk_run(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED
