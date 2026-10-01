extends Node2D

func _ready() -> void:
	var parsed: Variant = JSON.parse_string('{"a":2,"b":1}')
	print("typeof a: ", typeof(parsed["a"]), " TYPE_INT=", TYPE_INT, " strict==: ", typeof(parsed["a"]) == TYPE_INT)
	var p: Node = load("res://scripts/rpg_progress.gd").new()
	add_child(p)
	var dir := ProjectSettings.globalize_path("user://")
	var path := dir + "beta3_save.json"
	var f := FileAccess.open(path, FileAccess.WRITE)
	f.store_string('{"coins":10,"collected_berries":[1,2,3],"player_position":[352,272],"quest_stage":2,"version":1}')
	f.close()
	var loaded: bool = p.load_saved_game()
	print("int-position load: ", loaded, " stage=", p.get("quest_stage"), " coins=", p.get("coins"))
	f = FileAccess.open(path, FileAccess.WRITE)
	f.store_string('{"coins":10,"collected_berries":[1,2,3],"player_position":[352.0,272.0],"quest_stage":2,"version":1}')
	f.close()
	loaded = p.load_saved_game()
	print("float-position load: ", loaded, " stage=", p.get("quest_stage"))
	DirAccess.remove_absolute(path)
	get_tree().quit(0)
