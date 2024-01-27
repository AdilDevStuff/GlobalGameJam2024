extends Area2D

@onready var end_door_key_label: Label = $LevelEndDoorKey

func _process(_delta: float) -> void:
	if Global.is_end_key_collected:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		end_door_key_label.visible = true
		Global.is_in_end_key_range = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		end_door_key_label.visible = false
		Global.is_in_end_key_range = false
