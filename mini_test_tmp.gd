extends SceneTree

func _init() -> void:
	var ProgressScript := load("res://scripts/rpg_progress.gd")
	var p: Node = ProgressScript.new()
	root.add_child(p)
	var dir := ProjectSettings.globalize_path("user://")
	print("user dir: ", dir)
	var path := dir + "mini_save.json"
	var f := FileAccess.open(path, FileAccess.WRITE)
	f.store_string('{"coins":10,"collected_berries":[1,2,3],"player_position":[352.0,272.0],"quest_stage":2,"version":1}')
	f.close()
	print("written, exists=", FileAccess.file_exists(path))
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	print("parsed type: ", typeof(parsed), " is dict: ", parsed is Dictionary)
	if parsed is Dictionary:
		print("version: ", parsed.get("version"), " typeof: ", typeof(parsed.get("version")))
		print("stage typeof: ", typeof(parsed.get("quest_stage")))
		print("pos typeof: ", typeof(parsed.get("player_position")))
	quit(0)
