extends CharacterBody2D

@export var speed = 200.0
const JUMP_VELOCITY = -450.0

# Открытие механик
@export var is_jump_unlocked = false
@export var is_downwards_force_unlocked = false
enum MovementUnlockStatus { MOVE_FREELY, MOVE_WITH_DOWNWARD_FORCE, STICK_TO_SURFACE }
	
@export var current_unlock_status: MovementUnlockStatus = MovementUnlockStatus.MOVE_WITH_DOWNWARD_FORCE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _move_freely(input_direction: Vector2):
	velocity = input_direction * speed

func _move_with_downward_force(input_direction: Vector2, delta: float):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("Left"):
		velocity.x = -speed
	elif Input.is_action_pressed("Right"):
		velocity.x = speed
	else:
		velocity = velocity.lerp(Vector2(0, velocity.y), 0.3)
	_move_sticking_to_surface(input_direction)

func _move_sticking_to_surface(input_direction: Vector2):
	var collisions_count = get_slide_collision_count()
	for i in range(collisions_count):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print(collider)
	pass
	
func _get_input(delta: float):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	match current_unlock_status:
		MovementUnlockStatus.MOVE_FREELY:
			_move_freely(input_direction)
		MovementUnlockStatus.MOVE_WITH_DOWNWARD_FORCE:
			_move_with_downward_force(input_direction, delta)
		MovementUnlockStatus.STICK_TO_SURFACE:
			_move_sticking_to_surface(input_direction)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	_get_input(delta)
	move_and_slide()
