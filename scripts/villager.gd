extends Node2D

signal dialogue_requested(speaker: String, text: String)

@export var speaker_name := "Mira"
@export_multiline var dialogue_text := "Willkommen in unserem kleinen Dorf! Der Weg nach Osten führt zum alten Wald."
@export var interaction_range := 64.0


func _ready() -> void:
	add_to_group("interactable")


func interact(actor_position: Vector2) -> void:
	if global_position.distance_to(actor_position) > interaction_range:
		return

	dialogue_requested.emit(speaker_name, dialogue_text)
