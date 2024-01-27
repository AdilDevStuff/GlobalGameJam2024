extends Control

@onready var prompt: Label = $Prompt
@onready var captives_left_lable: Label = $CaptivesLeft
@onready var game_ui_anims: AnimationPlayer = $GameUIAnims

func _ready() -> void:
	game_ui_anims.play("In")

func _process(_delta: float) -> void:
	captives_left_lable.text = "Captives Left: %d" % Global.captives_left
	
	flashlight_key_prompts()
	
	captive_door_prompts()
	captive_room_key_prompts()
	
	captive_follow_prompts()
	
	end_room_key_prompts()
	end_door_prompts()

func captive_door_prompts():
	if Global.is_in_captive_door_range and !Global.is_captive_key_collected:
		if not Global.is_captive_door_opened:
			prompt.text = "Door Locked \n (Requires Captive Door Key)"
	elif Global.is_in_captive_door_range and Global.is_captive_key_collected:
		if not Global.is_captive_door_opened:
			prompt.text = "E To Open"
	else:
		prompt.text = ""

func captive_room_key_prompts():
	if Global.is_in_captive_key_range and !Global.is_captive_key_collected:
		prompt.text = "E To pickup"

func flashlight_key_prompts():
	if Global.is_in_flashlight_range and !Global.is_flashlight_collected:
		prompt.text = "E To pickup"

func captive_follow_prompts():
	if Global.is_in_captive_range and not Global.can_captives_follow_player:
		prompt.text = "E To Free Captive"

func end_room_key_prompts():
	if Global.is_in_end_key_range and !Global.is_end_key_collected:
		prompt.text = "E To pickup"

func end_door_prompts():
	if Global.is_in_end_door_range and !Global.is_end_key_collected:
		if not Global.is_end_door_opened:
			prompt.text = "Door Locked \n (Requires End Door Key)"
	elif Global.is_in_end_door_range and Global.is_end_key_collected:
		if not Global.is_end_door_opened:
			prompt.text = "E To Open"
