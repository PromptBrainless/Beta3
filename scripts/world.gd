extends Node2D

const VIEW_SIZE := Vector2(960, 544)
const TILE_SIZE := 32

@onready var player: RPGPlayer = $Player
@onready var villager: RPGVillager = $Villager

var dialogue_panel: PanelContainer
var speaker_label: Label
var dialogue_label: Label


func _ready() -> void:
	_setup_input_map()
	_build_hud()
	villager.dialogue_requested.connect(_on_dialogue_requested)


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact", false):
		return

	if dialogue_panel.visible:
		dialogue_panel.hide()
		player.movement_enabled = true
	else:
		get_tree().call_group("interactable", "interact", player.global_position)


func _draw() -> void:
	for row in range(17):
		for column in range(30):
			var tile_color := Color(0.24, 0.43, 0.27, 1)
			if (row + column) % 2 == 0:
				tile_color = Color(0.27, 0.47, 0.29, 1)
			draw_rect(
				Rect2(column * TILE_SIZE, row * TILE_SIZE, TILE_SIZE, TILE_SIZE),
				tile_color
			)

	draw_rect(Rect2(280, 240, 400, 64), Color(0.55, 0.43, 0.29, 1))
	draw_rect(Rect2(8, 8, VIEW_SIZE.x - 16, VIEW_SIZE.y - 16), Color(0.13, 0.23, 0.17, 1), false, 4)


func _setup_input_map() -> void:
	var bindings := {
		"move_up": [KEY_W, KEY_UP],
		"move_down": [KEY_S, KEY_DOWN],
		"move_left": [KEY_A, KEY_LEFT],
		"move_right": [KEY_D, KEY_RIGHT],
		"interact": [KEY_E],
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
	hint.text = "WASD / Pfeiltasten: Bewegen    E: Interagieren"
	hint.position = Vector2(24, 48)
	hud.add_child(hint)

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
	close_hint.text = "E zum Schließen"
	close_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	content.add_child(close_hint)


func _on_dialogue_requested(speaker: String, text: String) -> void:
	speaker_label.text = speaker
	dialogue_label.text = text
	dialogue_panel.show()
	player.movement_enabled = false
