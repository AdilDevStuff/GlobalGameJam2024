extends Area2D

@export var next_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if get_tree().current_scene != null:
			SceneTransition.change_scene(next_scene)
