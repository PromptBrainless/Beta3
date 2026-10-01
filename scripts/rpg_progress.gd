extends Node

signal progress_changed

const SAVE_PATH := "user://beta3_save.json"
const SAVE_VERSION := 1
const BERRY_GOAL := 3
const QUEST_NOT_STARTED := 0
const QUEST_ACTIVE := 1
const QUEST_COMPLETE := 2

var quest_stage := QUEST_NOT_STARTED
var collected_berries: Array[int] = []
var coins := 0
var saved_player_position := Vector2(352, 272)
var has_saved_position := false


func _ready() -> void:
	load_saved_game()


func collect_berry(berry_id: int, player_position: Vector2) -> bool:
	if quest_stage != QUEST_ACTIVE or berry_id in collected_berries:
		return false
	collected_berries.append(berry_id)
	saved_player_position = player_position
	has_saved_position = true
	save_game(player_position)
	progress_changed.emit()
	return true


func accept_quest(player_position: Vector2) -> void:
	quest_stage = QUEST_ACTIVE
	saved_player_position = player_position
	has_saved_position = true
	save_game(player_position)
	progress_changed.emit()


func complete_quest(player_position: Vector2) -> void:
	quest_stage = QUEST_COMPLETE
	coins += 10
	saved_player_position = player_position
	has_saved_position = true
	save_game(player_position)
	progress_changed.emit()


func save_game(player_position: Vector2) -> bool:
	saved_player_position = player_position
	has_saved_position = true
	var data := {
		"version": SAVE_VERSION,
		"quest_stage": quest_stage,
		"collected_berries": collected_berries,
		"coins": coins,
		"player_position": [player_position.x, player_position.y],
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(JSON.stringify(data))
	return file.get_error() == OK


func load_saved_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return false
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary or parsed.get("version") != SAVE_VERSION:
		return false
	var data: Dictionary = parsed
	var stage_value: Variant = data.get("quest_stage", QUEST_NOT_STARTED)
	var coins_value: Variant = data.get("coins", 0)
	var position_value: Variant = data.get("player_position", [])
	# JSON.parse_string liefert Zahlen als float; numerische Felder akzeptieren int und float.
	if typeof(stage_value) not in [TYPE_INT, TYPE_FLOAT] \
			or typeof(coins_value) not in [TYPE_INT, TYPE_FLOAT]:
		return false
	if typeof(position_value) != TYPE_ARRAY or position_value.size() != 2:
		return false
	if typeof(position_value[0]) not in [TYPE_INT, TYPE_FLOAT] \
			or typeof(position_value[1]) not in [TYPE_INT, TYPE_FLOAT]:
		return false
	var berry_values: Variant = data.get("collected_berries", [])
	if not berry_values is Array:
		return false
	quest_stage = clampi(int(stage_value), QUEST_NOT_STARTED, QUEST_COMPLETE)
	coins = maxi(int(coins_value), 0)
	collected_berries.clear()
	for berry_value in berry_values:
		if typeof(berry_value) in [TYPE_INT, TYPE_FLOAT] and int(berry_value) > 0 \
				and int(berry_value) not in collected_berries:
			collected_berries.append(int(berry_value))
	saved_player_position = Vector2(float(position_value[0]), float(position_value[1]))
	has_saved_position = true
	progress_changed.emit()
	return true
