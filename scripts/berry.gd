extends Node2D

@export var berry_id := 1
@export var interaction_range := 48.0


func _ready() -> void:
	add_to_group("interactable")
	visible = berry_id not in RPGProgress.collected_berries


func interact(actor_position: Vector2) -> void:
	if not visible or actor_position.distance_to(global_position) > interaction_range:
		return
	if RPGProgress.collect_berry(berry_id, actor_position):
		visible = false
