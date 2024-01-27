extends AnimatableBody2D

@onready var door_anims: AnimationPlayer = $DoorAnims
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	close_door()

func _process(_delta: float) -> void:
	if Global.is_in_captive_door_range:
		if Global.is_captive_key_collected:
			if Input.is_action_just_pressed("Pickup") and not Global.is_captive_door_opened:
				open_door()

func open_door():
	Global.is_captive_door_opened = true
	door_anims.play("OpenDoor")

func close_door():
	Global.is_captive_door_opened = false
	door_anims.play_backwards("OpenDoor")

func _on_door_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_captive_door_range = true

func _on_door_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_captive_door_range = false
