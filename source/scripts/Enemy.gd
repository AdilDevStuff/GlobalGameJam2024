extends CharacterBody2D

@export_category("Properties")
@export var follow_speed: float

@export_category("References")
@export var nav_agent: NavigationAgent2D

var direction
var random_position

var is_player_in_sight: bool = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var point: Node2D = $"../Point"
@onready var nav_region: NavigationRegion2D = $"../NavigationRegion2D"

func _ready() -> void:
	get_random_position()

func _physics_process(delta: float) -> void:
	match is_player_in_sight:
		true:
			follow_player()
		false:
			move_to_random_position()
	
	move_and_slide()

func set_target_location(target_pos):
	nav_agent.target_position = target_pos

func follow_player():
	await get_tree().process_frame
	look_at(player.global_position)
	set_target_location(player.global_position)
	
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * follow_speed, 0.1)

# Move toward random point if its within the baked mesh otherwise find another random position
func move_to_random_position():
	look_at(random_position)
	await get_tree().process_frame
	set_target_location(random_position)
	if nav_agent.is_target_reachable():
		if int(nav_agent.distance_to_target()) > 1: # Fix enemy jitter when target reached
			direction = nav_agent.get_next_path_position() - global_position
			direction = direction.normalized()
			velocity = velocity.lerp(direction * follow_speed, 0.1)
	else:
		get_random_position()

func get_random_position():
	var screen_size = get_viewport_rect().size
	random_position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	point.position = random_position
	return random_position

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = velocity.move_toward(safe_velocity, get_process_delta_time() * 40)
	move_and_slide()

func _on_navigation_agent_2d_target_reached() -> void:
	get_random_position()

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_sight = true

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_sight = false
		get_random_position()

