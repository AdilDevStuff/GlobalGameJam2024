extends Area2D


func _process(_delta: float) -> void:
	if Global.have_captive_unlock_key:
		queue_free()
