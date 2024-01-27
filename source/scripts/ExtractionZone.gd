extends Area2D

@export var next_scene: PackedScene
@export var captives_group: Node2D

func _ready() -> void:
	Global.captives_left = captives_group.get_child_count()

func _process(_delta: float) -> void:
	if Global.captives_left <= 0:
		Global.reset_all_bools()
		SceneTransition.change_scene(next_scene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Captive"):
		Global.captives_left -= 1
		body.queue_free()


