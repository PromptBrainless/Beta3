extends Node2D

const WORLD_SIZE := Vector2(1920, 1088)
const TILE_SIZE := 32

@onready var player: RPGPlayer = $Player
@onready var villager: RPGVillager = $Villager

var dialogue_panel: PanelContainer
var speaker_label: Label
var dialogue_label: Label
var quest_label: Label
var status_label: Label


func _ready() -> void:
	_setup_input_map()
	_build_hud()
	villager.dialogue_requested.connect(_on_dialogue_requested)
	RPGProgress.progress_changed.connect(_update_status)
	if RPGProgress.has_saved_position:
		player.global_position = RPGProgress.saved_player_position.clamp(
			player.WORLD_MIN, player.WORLD_MAX
		)
	_refresh_berries()
	_update_status()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		_show_status("Spiel gespeichert." if RPGProgress.save_game(player.global_position) else "Speichern fehlgeschlagen.")
		return
	if event.is_action_pressed("load_game"):
		if RPGProgress.load_saved_game():
			player.global_position = RPGProgress.saved_player_position.clamp(
				player.WORLD_MIN, player.WORLD_MAX
			)
			_refresh_berries()
			_show_status("Spielstand geladen.")
		else:
			_show_status("Kein gueltiger Spielstand vorhanden.")
		return
	if not event.is_action_pressed("interact", false):
		return
	if dialogue_panel.visible:
		dialogue_panel.hide()
		player.movement_enabled = true
	else:
		get_tree().call_group("interactable", "interact", player.global_position)


func _draw() -> void:
	for row in range(int(WORLD_SIZE.y / TILE_SIZE)):
		for column in range(int(WORLD_SIZE.x / TILE_SIZE)):
			var tile_color := Color(0.24, 0.43, 0.27, 1)
			if (row + column) % 2 == 0:
				tile_color = Color(0.27, 0.47, 0.29, 1)
			draw_rect(Rect2(column * TILE_SIZE, row * TILE_SIZE, TILE_SIZE, TILE_SIZE), tile_color)

	draw_rect(Rect2(0, 240, 1200, 64), Color(0.55, 0.43, 0.29, 1))
	draw_rect(Rect2(568, 240, 64, 560), Color(0.55, 0.43, 0.29, 1))
	draw_rect(Rect2(1100, 240, 64, 560), Color(0.55, 0.43, 0.29, 1))
	draw_rect(Rect2(1100, 736, 500, 64), Color(0.55, 0.43, 0.29, 1))
	draw_rect(Rect2(760, 64, 280, 160), Color(0.15, 0.37, 0.58, 1))
	draw_rect(Rect2(8, 8, WORLD_SIZE.x - 16, WORLD_SIZE.y - 16), Color(0.13, 0.23, 0.17, 1), false, 8)

	for tree_position in [
		Vector2(1280, 600), Vector2(1408, 576), Vector2(1536, 640),
		Vector2(1664, 576), Vector2(1792, 672), Vector2(1344, 832),
		Vector2(1472, 896), Vector2(1600, 832), Vector2(1728, 928)
	]:
		draw_circle(tree_position, 28, Color(0.12, 0.30, 0.16, 1))
		draw_circle(tree_position + Vector2(-8, -8), 16, Color(0.20, 0.42, 0.21, 1))


func _setup_input_map() -> void:
	var bindings := {
		"move_up": [KEY_W, KEY_UP],
		"move_down": [KEY_S, KEY_DOWN],
		"move_left": [KEY_A, KEY_LEFT],
		"move_right": [KEY_D, KEY_RIGHT],
		"interact": [KEY_E],
		"save_game": [KEY_F5],
		"load_game": [KEY_F9],
	}
	for action_name in bindings:
		if not InputMap.has_action(action_name):
			InputMap.add_action(action_name)
		for key_code in bindings[action_name]:
			var key_event := InputEventKey.new()
			key_event.physical_keycode = key_code
			if not InputMap.action_has_event(action_name, key_event):
				InputMap.action_add_event(action_name, key_event)


func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var hud := Control.new()
	hud.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(hud)

	var title := Label.new()
	title.text = "BETA3  ·  DAS DORF"
	title.position = Vector2(24, 18)
	title.add_theme_font_size_override("font_size", 20)
	hud.add_child(title)

	var hint := Label.new()
	hint.text = "WASD / Pfeile: Bewegen    E: Interagieren    F5: Speichern    F9: Laden"
	hint.position = Vector2(24, 48)
	hud.add_child(hint)

	quest_label = Label.new()
	quest_label.position = Vector2(24, 78)
	hud.add_child(quest_label)

	status_label = Label.new()
	status_label.position = Vector2(24, 104)
	hud.add_child(status_label)

	dialogue_panel = PanelContainer.new()
	dialogue_panel.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
	dialogue_panel.offset_left = 24
	dialogue_panel.offset_top = -132
	dialogue_panel.offset_right = -24
	dialogue_panel.offset_bottom = -20
	dialogue_panel.hide()
	hud.add_child(dialogue_panel)

	var content := VBoxContainer.new()
	dialogue_panel.add_child(content)

	speaker_label = Label.new()
	speaker_label.add_theme_font_size_override("font_size", 20)
	content.add_child(speaker_label)

	dialogue_label = Label.new()
	dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	content.add_child(dialogue_label)

	var close_hint := Label.new()
	close_hint.text = "E zum Schliessen"
	close_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	content.add_child(close_hint)


func _on_dialogue_requested(speaker: String, text: String) -> void:
	speaker_label.text = speaker
	dialogue_label.text = text
	dialogue_panel.show()
	player.movement_enabled = false
	_update_status()


func _update_status() -> void:
	if RPGProgress.quest_stage == RPGProgress.QUEST_NOT_STARTED:
		quest_label.text = "Auftrag: Sprich mit Mira."
	elif RPGProgress.quest_stage == RPGProgress.QUEST_ACTIVE:
		quest_label.text = (
			"Auftrag: Waldbeeren %d/%d"
			% [RPGProgress.collected_berries.size(), RPGProgress.BERRY_GOAL]
		)
	else:
		quest_label.text = "Auftrag erledigt!"
	_show_status(
		"Beeren: %d    Gold: %d"
		% [RPGProgress.collected_berries.size(), RPGProgress.coins]
	)


func _show_status(message: String) -> void:
	if status_label:
		status_label.text = message


func _refresh_berries() -> void:
	for item in get_tree().get_nodes_in_group("interactable"):
		if item.has_method("interact") and item != villager:
			item.set("visible", item.get("berry_id") not in RPGProgress.collected_berries)
