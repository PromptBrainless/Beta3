extends StaticBody2D

class_name RPGVillager

signal dialogue_requested(speaker: String, text: String)

@export var speaker_name := "Mira"
@export var interaction_range := 64.0


func _ready() -> void:
	add_to_group("interactable")


func interact(actor_position: Vector2) -> void:
	if global_position.distance_to(actor_position) > interaction_range:
		return
	if RPGProgress.quest_stage == RPGProgress.QUEST_NOT_STARTED:
		RPGProgress.accept_quest(actor_position)
		dialogue_requested.emit(
			speaker_name,
			"Kannst du mir drei Waldbeeren bringen? Der Pfad nach Osten führt in den Wald."
		)
	elif RPGProgress.quest_stage == RPGProgress.QUEST_ACTIVE:
		if RPGProgress.collected_berries.size() >= RPGProgress.BERRY_GOAL:
			RPGProgress.complete_quest(actor_position)
			dialogue_requested.emit(
				speaker_name,
				"Vielen Dank! Hier sind 10 Goldstücke als Belohnung."
			)
		else:
			dialogue_requested.emit(
				speaker_name,
				"Du hast %d von %d Beeren gefunden. Suche weiter im Wald."
				% [RPGProgress.collected_berries.size(), RPGProgress.BERRY_GOAL]
			)
	else:
		dialogue_requested.emit(speaker_name, "Danke für deine Hilfe. Pass gut auf dich auf!")
