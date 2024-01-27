extends AnimatableBody2D

@onready var door_anims: AnimationPlayer = $DoorAnims

var is_captive_room_door_opened: bool = false

func open_door():
	door_anims.play("OpenDoor")

func close_door():
	door_anims.play_backwards("OpenDoor")
