extends Area2D

@onready var flashlight_label: Label = $Flashlight

func _process(_delta: float) -> void:
	if Global.is_flashlight_collected:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		flashlight_label.visible = true
		Global.is_in_flashlight_range = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		flashlight_label.visible = false
		Global.is_in_flashlight_range = false

