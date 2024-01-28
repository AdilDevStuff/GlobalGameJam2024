extends CharacterBody2D

@export var speed: float = 400
@onready var light: PointLight2D = $PointLight2D
@onready var pickup_sfx: AudioStreamPlayer2D = $PickupSfx

func _physics_process(_delta: float) -> void:
	movement()
	
	pickup_flashlight()
	pickup_captive_key()
	pickup_level_end_key()
	make_captives_follow_player()

func movement():
	look_at(get_global_mouse_position())
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_vector if input_vector else Vector2.ZERO
	velocity = velocity.normalized() * speed
	move_and_slide()

func pickup_captive_key():
	if Global.is_in_captive_key_range:
		if Input.is_action_just_pressed("Pickup"):
			pickup_sfx.play()
			Global.is_captive_key_collected = true

func pickup_flashlight():
	if Global.is_in_flashlight_range:
		if Input.is_action_just_pressed("Pickup"):
			pickup_sfx.play()
			Global.is_flashlight_collected = true
			light.energy = 1

func pickup_level_end_key():
	if Global.is_in_end_key_range:
		if Input.is_action_just_pressed("Pickup"):
			pickup_sfx.play()
			Global.is_end_key_collected = true

func make_captives_follow_player():
	if Global.is_in_captive_range:
		if Input.is_action_just_pressed("Pickup"):
			Global.can_captives_follow_player = !Global.can_captives_follow_player 
