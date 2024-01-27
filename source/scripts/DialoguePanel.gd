extends Panel

@export var character_name: String
@export var dialogues: Array[String] = [
	"Uhhhh...where am i?",
	"How did i get here??",
	"uhhhh, my head hurts..."
	]

var current_index = 0

@onready var character_name_label: Label = $Header/CharacterName
@onready var dialogue_label: RichTextLabel = $Dialogue
@onready var dialogue_anims: AnimationPlayer = $DialogueAnims

func _ready() -> void:
	dialogue_anims.play("load")

func _process(_delta: float) -> void:
	character_name_label.text = character_name
	if current_index < dialogues.size():
		dialogue_label.text = dialogues[current_index]
	else:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0.001,0.001), 0.2)
		await tween.finished
		queue_free()

func _on_continue_pressed() -> void:
	if current_index < dialogues.size():
		dialogue_anims.play("load")
		current_index += 1
