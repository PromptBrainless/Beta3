extends Node2D

## Headless-Test für den RPG-Quest-Loop. Aufruf: Hauptszene zeitweise auf
## res://tests/quest_loop_test.tscn setzen und mit `godot --headless` starten.

var _failures: Array[String] = []
var _save_dir: String


func _ready() -> void:
	_save_dir = ProjectSettings.globalize_path("user://")
	_run_tests.call_deferred()


func _run_tests() -> void:
	var world: Node2D = $World
	await get_tree().process_frame
	await get_tree().process_frame

	var player: CharacterBody2D = world.get_node("Player")
	var villager: Node2D = world.get_node("Villager")

	_check(RPGProgress.quest_stage == RPGProgress.QUEST_NOT_STARTED, "quest starts unstarted")
	_check(RPGProgress.coins == 0, "coins start at 0")
	_check(player.movement_enabled, "player movement enabled at start")

	player.global_position = villager.global_position + Vector2(-80, 0)
	Input.action_press("move_right")
	for i in range(120):
		await get_tree().physics_frame
	Input.action_release("move_right")
	_check(player.global_position.x < villager.global_position.x - 10.0,
		"villager blocks player movement")

	player.global_position = villager.global_position + Vector2(-40, 0)
	villager.interact(player.global_position)
	await get_tree().process_frame
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_ACTIVE, "quest accepted")
	var panels := world.find_children("*", "PanelContainer", true, false)
	var dialogue_panel: Control = panels[0] if not panels.is_empty() else null
	_check(dialogue_panel != null and dialogue_panel.visible, "dialogue panel visible after talking")

	var key := InputEventAction.new()
	key.action = "interact"
	key.pressed = true
	world._unhandled_input(key)
	await get_tree().process_frame
	_check(player.movement_enabled, "movement re-enabled after closing dialogue")

	var berry_count := 0
	for item in get_tree().get_nodes_in_group("interactable"):
		if item != villager and item.has_method("interact"):
			item.interact(item.global_position)
			berry_count += 1
	await get_tree().process_frame
	_check(berry_count == 3, "exactly three berries exist")
	_check(RPGProgress.collected_berries.size() == 3, "all berries collected")
	_check(_save_file() != null, "autosave file written")

	for item in get_tree().get_nodes_in_group("interactable"):
		if item != villager and item.has_method("interact"):
			item.interact(item.global_position)
	_check(RPGProgress.collected_berries.size() == 3, "berry collection is idempotent")

	player.global_position = villager.global_position + Vector2(-40, 0)
	villager.interact(player.global_position)
	await get_tree().process_frame
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_COMPLETE, "quest completed")
	_check(RPGProgress.coins == 10, "reward is 10 gold")

	_check(RPGProgress.save_game(Vector2(352, 272)), "manual save succeeds")
	var saved_json: String = _save_file().get_as_text()
	RPGProgress.quest_stage = RPGProgress.QUEST_NOT_STARTED
	RPGProgress.coins = 0
	RPGProgress.collected_berries.clear()
	_check(_load_json(saved_json), "manual load succeeds")
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_COMPLETE, "quest stage restored")
	_check(RPGProgress.coins == 10, "coins restored")
	_check(RPGProgress.collected_berries.size() == 3, "berries restored")
	_check(RPGProgress.saved_player_position == Vector2(352, 272), "position restored")

	_check(not _load_json("{\"version\": 999}"), "incompatible save rejected")
	_check(not _load_json("not json"), "corrupt save rejected")

	_clear_save()
	if _failures.is_empty():
		print("QUEST LOOP TEST: ALL CHECKS PASSED")
		get_tree().quit(0)
	else:
		for failure in _failures:
			printerr("FAILED: " + failure)
		get_tree().quit(1)


func _save_file() -> FileAccess:
	var path := _save_dir + "beta3_save.json"
	if not FileAccess.file_exists(path):
		return null
	return FileAccess.open(path, FileAccess.READ)


func _load_json(text: String) -> bool:
	var path := _save_dir + "beta3_save.json"
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(text)
	file.close()
	var loaded: bool = RPGProgress.load_saved_game()
	DirAccess.remove_absolute(path)
	return loaded


func _clear_save() -> void:
	DirAccess.remove_absolute(_save_dir + "beta3_save.json")


func _check(condition: bool, label: String) -> void:
	if condition:
		print("PASS: " + label)
	else:
		_failures.append(label)
