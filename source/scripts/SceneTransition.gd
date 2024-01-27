extends CanvasLayer

@onready var scene_trans_anim: AnimationPlayer = $SceneTransAnim
@onready var black: ColorRect = $Black

func change_scene(target_scene: PackedScene):
	scene_trans_anim.play("Enter")
	await scene_trans_anim.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	scene_trans_anim.play_backwards("Enter")
