extends AnimatableBody2D

@onready var door_anim: AnimationPlayer = $DoorAnim
@onready var door_open: AudioStreamPlayer2D = $DoorOpen

func _process(_delta: float) -> void:
	if Global.is_in_end_door_range:
		if Global.is_end_key_collected:
			if Input.is_action_just_pressed("Pickup") and not Global.is_end_door_opened:
				open_door()

func open_door():
	door_open.play()
	Global.is_end_door_opened = true
	door_anim.play("OpenDoor")

func close_door():
	Global.is_end_door_opened = false
	door_anim.play_backwards("OpenDoor")

func _on_door_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_end_door_range = true

func _on_door_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.is_in_end_door_range = false
