extends CharacterBody2D

@export var move_speed: float = 180.0
var movement_enabled := true

const WORLD_MIN := Vector2(24, 24)
const WORLD_MAX := Vector2(936, 520)


func _physics_process(_delta: float) -> void:
	if not movement_enabled:
		velocity = Vector2.ZERO
		return

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()
	global_position = global_position.clamp(WORLD_MIN, WORLD_MAX)

	if Input.is_action_just_pressed("interact"):
		get_tree().call_group("interactable", "interact", global_position)
