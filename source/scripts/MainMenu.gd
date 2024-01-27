extends Control

@export var game_scene: PackedScene

func _ready() -> void:
	SceneTransition.black.visible = false

func _on_play_pressed() -> void:
	SceneTransition.change_scene(game_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
