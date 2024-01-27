extends CharacterBody2D

@export var speed: float = 400

func _physics_process(_delta: float) -> void:
	movement()

func movement():
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_vector if input_vector else Vector2.ZERO
	velocity = velocity.normalized() * speed
	move_and_slide()
