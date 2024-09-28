class_name Player extends CharacterBody2D

# Player Nodes
var Collider;
var Animator;
var Sprite;
var Camera;

# Player movement
const SPEED = 160;
const JUMP_VELOCITY = -290.0;
var GRAVITY = 600;
var Facing;
var SpriteXScale;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the nodes
	Collider = get_node("Collider");
	Animator = get_node("Animator");
	Sprite = get_node("Sprite");
	Camera = get_node("Camera");
	
	# Get the current sprite scale
	SpriteXScale = Sprite.scale.x;
	Facing = SpriteXScale;
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get which way the player is facing
	if (Input.is_action_just_pressed("MoveRight")):
		Facing = SpriteXScale;
	if (Input.is_action_just_pressed("MoveLeft")):
		Facing = -SpriteXScale;
		
	pass

func _physics_process(delta: float) -> void:
	# Add gravity
	if (!is_on_floor()):
		velocity.y += GRAVITY * delta;
	
	# Handle player jump
	if (Input.is_action_just_pressed("MoveUp") and is_on_floor()):
		velocity.y = JUMP_VELOCITY;
	
	# Get the horizontal input direction
	var inputDirection = Input.get_axis("MoveLeft", "MoveRight")
	if (inputDirection):
		velocity.x = inputDirection * SPEED;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
	
	HandleAnimations()
	move_and_slide()

func HandleAnimations() -> void:
	# Handle running
	if (is_on_floor()):
		if (velocity.x != 0):
			Animator.play("player_run");
		if (velocity.x == 0):
			Animator.play("player_idle");
	else:
		if (velocity.y < -10):
			Animator.play("player_jump_up");
		elif (velocity.y > -10 and velocity.y < 10):
			Animator.play("player_jump_transition");
		else:
			Animator.play("player_fall");
	
	# Handle x-scale
	Sprite.scale.x = Facing;
	
	pass
