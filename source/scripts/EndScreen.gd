extends Control

@export var main_menu: PackedScene

func _on_menu_pressed() -> void:
	SceneTransition.change_scene(main_menu)

func _on_quit_pressed() -> void:
	get_tree().quit()
