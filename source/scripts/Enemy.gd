extends CharacterBody2D

@export_category("Properties")
@export var follow_speed: float

@export_category("References")
@export var nav_agent: NavigationAgent2D

var direction
var random_position

var is_player_in_sight: bool = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var game_over_screen: Control = $"../../UserInterface/GameOverScreen"

func _ready() -> void:
	get_random_position()

func _physics_process(_delta: float) -> void:
	match is_player_in_sight:
		true:
			if player:
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
	
	if player.is_inside_tree():
		direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * follow_speed, 0.1)

# Move toward random point if its within the baked mesh otherwise find another random position
func move_to_random_position():
	look_at(nav_agent.get_next_path_position())
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
	random_position = Vector2(randf_range(0, 3264), randf_range(0, 1864))
	return random_position

func _on_navigation_agent_2d_target_reached() -> void:
	get_random_position()

# Player Enters Vision Cone
func _on_enemy_vision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not body.is_in_group("Wall"):
		is_player_in_sight = true

func _on_enemy_vision_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_sight = false
		get_random_position()

# Player Enters Enemy Range (Game Over)
func _on_enemy_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.reset_all_bools()
		Engine.time_scale = 0
		game_over_screen.visible = true
