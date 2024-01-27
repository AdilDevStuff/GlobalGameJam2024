extends Node

var have_captive_unlock_key: bool = false
var is_in_captive_key_range: bool = false

var have_end_unlock_key: bool = false
var is_in_end_key_range: bool = false

var is_captive_key_collected: bool = false
var is_in_captive_door_range: bool = false
var is_captive_door_opened: bool = false

var is_flashlight_collected: bool = false
var is_in_flashlight_range: bool = false
var flashlight_toggled: bool = false

var is_end_key_collected: bool = false
var is_in_end_door_range: bool = false
var is_end_door_opened: bool = false

var can_captives_follow_player: bool = false
var is_in_captive_range: bool = false

var captives_left: int = 0

var current_day: int = 0

func reset_all_bools():
	Global.have_captive_unlock_key = false
	Global.is_in_captive_key_range = false

	Global.have_end_unlock_key = false
	Global.is_in_end_key_range = false

	Global.is_captive_key_collected = false
	Global.is_in_captive_door_range = false
	Global.is_captive_door_opened = false

	Global.is_end_key_collected = false
	Global.is_in_end_door_range = false
	Global.is_end_door_opened = false

	Global.can_captives_follow_player = false
	Global.is_in_captive_range = false
