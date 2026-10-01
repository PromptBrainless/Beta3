extends SceneTree

var RPGProgress: Node




var _failures: Array[String] = []


func _init() -> void:
	RPGProgress = load("res://scripts/rpg_progress.gd").new()
	RPGProgress.name = "RPGProgress"
	root.add_child(RPGProgress)
	await process_frame
	var world_scene: PackedScene = load("res://scenes/world.tscn")
	assert(world_scene != null, "world.tscn loads")
	var world: Node2D = world_scene.instantiate()
	root.add_child(world)
	await process_frame
	await process_frame

	var player: CharacterBody2D = world.get_node("Player")
	var villager: Node2D = world.get_node("Villager")

	_check(RPGProgress.quest_stage == RPGProgress.QUEST_NOT_STARTED, "quest starts unstarted")
	_check(RPGProgress.coins == 0, "coins start at 0")
	_check(player.movement_enabled, "player movement enabled at start")

	# Player must not pass through the villager body.
	player.global_position = villager.global_position + Vector2(-80, 0)
	Input.action_press("move_right")
	for i in range(120):
		await physics_frame
	Input.action_release("move_right")
	_check(player.global_position.x < villager.global_position.x - 10.0,
		"villager blocks player movement (x=%f vs villager x=%f)" % [player.global_position.x, villager.global_position.x])

	# Accept Mira's quest.
	player.global_position = villager.global_position + Vector2(-40, 0)
	villager.interact(player.global_position)
	await process_frame
	print("DEBUG: dist=", player.global_position.distance_to(villager.global_position),
		" range=", villager.interaction_range, " stage=", RPGProgress.quest_stage,
		" our_stage_var=", RPGProgress.get("quest_stage"),
		" villager_sees=", villager.get("RPGProgress") if false else "n/a",
		" root_children=", root.get_children().map(func(c): return c.name))
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_ACTIVE, "quest accepted")
	var dialogue_panel: Control = _find_dialogue_panel(world)
	_check(dialogue_panel != null and dialogue_panel.visible, "dialogue panel visible after talking")

	# Close dialogue via input event so movement is re-enabled.
	var key := InputEventAction.new()
	key.action = "interact"
	key.pressed = true
	world._unhandled_input(key)
	await process_frame
	_check(player.movement_enabled, "movement re-enabled after closing dialogue")

	# Collect the three berries.
	var berry_ids: Array[int] = []
	for item in get_nodes_in_group("interactable"):
		if item != villager and item.has_method("interact"):
			item.interact(item.global_position)
			berry_ids.append(item.get("berry_id"))
	await process_frame
	_check(berry_ids.size() == 3, "exactly three berries exist (found %d)" % berry_ids.size())
	_check(RPGProgress.collected_berries.size() == 3, "all berries collected")
	_check(FileAccess.file_exists(RPGProgress.SAVE_PATH), "autosave file written")

	# Double interaction must not duplicate berries.
	for item in get_nodes_in_group("interactable"):
		if item != villager and item.has_method("interact"):
			item.interact(item.global_position)
	_check(RPGProgress.collected_berries.size() == 3, "berry collection is idempotent")

	# Claim the reward at Mira.
	player.global_position = villager.global_position + Vector2(-40, 0)
	villager.interact(player.global_position)
	await process_frame
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_COMPLETE, "quest completed")
	_check(RPGProgress.coins == 10, "reward is 10 gold (got %d)" % RPGProgress.coins)

	# Save, mutate state, then load (F9 behaviour).
	_check(RPGProgress.save_game(Vector2(352, 272)), "manual save succeeds")
	RPGProgress.quest_stage = RPGProgress.QUEST_NOT_STARTED
	RPGProgress.coins = 0
	RPGProgress.collected_berries.clear()
	_check(RPGProgress.load_saved_game(), "manual load succeeds")
	_check(RPGProgress.quest_stage == RPGProgress.QUEST_COMPLETE, "quest stage restored")
	_check(RPGProgress.coins == 10, "coins restored")
	_check(RPGProgress.collected_berries.size() == 3, "berries restored")
	_check(RPGProgress.saved_player_position == Vector2(352, 272), "position restored")

	# Corrupted save must be rejected, not crash.
	var file := FileAccess.open(RPGProgress.SAVE_PATH, FileAccess.WRITE)
	file.store_string("{\"version\": 999}")
	file.close()
	_check(not RPGProgress.load_saved_game(), "incompatible save rejected")

	# Clean up the test save so no residue remains.
	DirAccess.remove_absolute(ProjectSettings.globalize_path(RPGProgress.SAVE_PATH))

	if _failures.is_empty():
		print("QUEST LOOP TEST: ALL CHECKS PASSED")
		quit(0)
	else:
		for failure in _failures:
			printerr("FAILED: " + failure)
		quit(1)


func _check(condition: bool, label: String) -> void:
	if condition:
		print("PASS: " + label)
	else:
		_failures.append(label)


func _find_dialogue_panel(world: Node) -> Control:
	for node in world.find_children("*", "PanelContainer", true, false):
		return node
	return null
