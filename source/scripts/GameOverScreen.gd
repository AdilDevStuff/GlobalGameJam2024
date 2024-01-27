extends Control

@export var gameover_text: Array[String]
@onready var you_died: Label = $YouDied

func _ready() -> void:
	SceneTransition.black.visible = false
	you_died.text = gameover_text.pick_random()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
