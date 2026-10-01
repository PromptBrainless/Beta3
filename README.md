# Beta3 RPG

A Godot 4.7 2D RPG starter built on [Maaack's Game Template](https://github.com/Maaack/Godot-Game-Template). The template provides the opening flow, main/options/pause menus, settings, audio controllers, and asynchronous scene loading. Its example game levels remain in the project but are not combined with this RPG's gameplay.

## Run

Open this repository root in Godot 4.7 and run the project. The main scene opens the template intro and menu; starting a game loads the RPG world.

## Play

- Move: WASD or arrow keys
- Talk / collect: E
- Save: F5
- Load: F9

Speak to Mira, collect three berries in the eastern woods, then return to receive 10 gold. Progress and player position are written as JSON to `user://beta3_save.json`.

## Project contents

- `scenes/world.tscn` and `scripts/` — the playable RPG slice.
- `scenes/game/game.tscn` — template game shell and level loading, configured to launch the RPG world.
- `addons/maaacks_*` — the template's game, scene-loading, music, and UI sound systems.
- `GODOT_PLUGIN_REVIEW.md` — audit and adoption status of all 117 collected plugin/resource archives.

The archive catalog is not a dependency manifest: only the selected template is integrated. RPG add-ons remain candidates until individually validated for Godot 4.7, licensing, and fit.
