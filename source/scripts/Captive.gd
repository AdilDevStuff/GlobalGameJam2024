extends CharacterBody2D

@export var follow_speed: float

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var direction

func _physics_process(_delta: float) -> void:
	set_target_location(player.global_position)
	if Global.can_captives_follow_player:
		follow_player()

func follow_player():
	look_at(player.global_position)
	var currentLocation = global_transform.origin
	await get_tree().process_frame
	if player.is_inside_tree():
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = currentLocation.direction_to(next_location)
		nav_agent.velocity = new_velocity * follow_speed

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if Global.can_captives_follow_player:
		velocity = velocity.lerp(safe_velocity, 0.1)
		move_and_slide()

func set_target_location(target_pos):
	nav_agent.target_position = target_pos

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_captive_range = true

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_captive_range = false

