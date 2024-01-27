extends CharacterBody2D

@export var speed: float = 400

@export_group("Refs")
@export var pickup_label: Label

var is_in_pickup_range: bool = false
var pickup_picked: bool = false

func _physics_process(_delta: float) -> void:
	movement()
	pickup_label.visible = true if is_in_pickup_range else false
	
	if is_in_pickup_range:
		if Input.is_action_just_pressed("Pickup"):
			Global.have_captive_unlock_key = true

func movement():
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_vector if input_vector else Vector2.ZERO
	velocity = velocity.normalized() * speed
	move_and_slide()

func _on_pickup_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("CaptiveKey") or area.is_in_group("Pickup"):
		is_in_pickup_range = true

func _on_pickup_range_area_exited(area: Area2D) -> void:
	if area.is_in_group("CaptiveKey") or area.is_in_group("Pickup"):
		is_in_pickup_range = false
