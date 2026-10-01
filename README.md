# Beta3 RPG

A Godot 4.7 2D RPG starter project. The first playable slice is intentionally
small: move around a placeholder town, speak to the villager, and view a
dialogue. It uses built-in Godot nodes and GDScript only; the collected addon
archives have not been installed or treated as trusted project dependencies.

## Open and run

Open this repository's root directory in Godot 4.7, then run the project (F6/F5
or the Run Project button). The main scene is
`/home/runner/work/Beta3/Beta3/scenes/world.tscn`.

## Controls

- Move: WASD or arrow keys
- Talk / close dialogue: E

## Project layout

- `project.godot` — Godot project settings and main scene.
- `scenes/world.tscn` — starter town, player, and villager.
- `scripts/` — movement, interaction, and world presentation.

The scene currently uses drawn placeholder tiles and character shapes rather
than external art. The plugins reviewed in
[`GODOT_PLUGIN_REVIEW.md`](GODOT_PLUGIN_REVIEW.md) remain candidates only;
install and validate them individually after the Godot version and gameplay
data model have been confirmed.
