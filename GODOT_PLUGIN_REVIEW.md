# Godot archive review

**Status: implementation started; runtime validation still pending.** This repository has 117 ZIP archives and targets a 2D RPG using Godot 4.7. Maaack's selected template and its bundled menu, scene-loader, music, and UI sound plugins now form the project base; they have not yet been smoke-tested in this project. Other shortlisted addons remain candidates, not installed dependencies.

All 117 archives were fully extracted and re-inspected (plugin.cfg manifests, READMEs and license files read directly) to verify the claims below; this pass confirmed the prior findings and corrected two bundle-content details (BBCodeEdit and Godot4QuestEditor, noted in their table rows). `addons/maaacks_game_template/plugin.cfg` in this project reports version 1.7.1, matching `plugins/archives/foundation/Godot-Game-Template-main.zip`.

The review uses archive names and included manifests, READMEs, project files and license files where available. `awesome-godot` is used as a discovery/curation signal, not as proof of compatibility or quality. The upstream README at <https://github.com/Calinou/awesome-godot> was checked on 2026-10-01; it currently lists Maaack's Game Template, Questify, and GUT. The generic `sindresorhus/awesome` list is not a Godot plugin audit.

The Drive folder linked in `/home/runner/work/Beta3/Beta3/Google drive with all godot foundations` could not be read in this environment. Its contents are **not** included in the 117-archive count or in either decision list below.

All archives are sorted into category folders under `plugins/archives/` (see [plugins/README.md](plugins/README.md)); the table rows below link to their current paths.

## Content overview

The archive collection is a library to draw from, not one combined project. Keep shipped game content, runtime systems, and editor-only helpers separate:

| Type | Collected examples | Use in this project |
| --- | --- | --- |
| Game content | `plugins/archives/art/1_Free_Pack.zip`, `plugins/archives/art/MorbidEmber_pixel-RPG-starter-pack_v1.1-2.zip`, `plugins/archives/art/GoldenSkullArt_2D_Iso_Free_Starter_Bundle-2.zip`, `plugins/archives/art/Card_Game_GFX.zip`, `plugins/archives/art/natural_lut-2.zip` | Art and effects are not runtime systems. Do not use/redistribute packs until art direction and asset rights are verified. |
| Runtime/game systems | `dialogic-*.zip`, `plugins/archives/gameplay/Questify-1.6.0.zip`, `p0nni_inventory_system-*.zip`, `godot-statecharts-*.zip`, `plugins/archives/ui/gohud-1.2.1.zip`, `eMessagePipe-*.zip` | Potential dialogue, quest, inventory, state, HUD, or platform functionality. Select at most one implementation per need and test compatibility/export implications before adoption. |
| Editor authoring tools | `plugins/archives/tile-map/BetterTileEditor-0.1.0.zip`, `AutotileEditor-*.zip`, `WorldEditor-*.zip`, `Godot4DialogueEditor-*.zip`, `Godot4QuestEditor-*.zip`, sprite/graphics editor archives | These alter content-authoring workflows; they are not automatically shipped-game dependencies. |
| Editor comfort and QA | `plugins/archives/testing/Gut-9.6.1.zip`, `input-audit-lite-*.zip`, `loc-audit-lite-*.zip`, editor themes, notes, external-editor and logging archives | Keep tools separate from runtime. GUT is the strongest test candidate; other utilities need a concrete workflow need. |
| Alternate templates / bundled frameworks | `plugins/archives/templates/TakinGodotTemplate-master.zip`, `plugins/archives/templates/godot-game-template-main (1).zip`, `plugins/archives/templates/godot-template-4.x.zip`, `plugins/archives/templates/fuse-v1.1.0.zip`, `Ruake-*.zip` | Do not stack templates/frameworks. Maaack is the single selected base; overlapping alternatives remain unintegrated. |

### Verified candidate details

| Candidate | Compatibility and useful detail | License / decision |
| --- | --- | --- |
| Maaack's Game Template (`plugins/archives/foundation/Godot-Game-Template-main.zip`) | README says Godot 4.7 (4.4+ compatible); includes menus, input/settings, pause, credits, and scene loading. Its bundled Scene Loader documents `SceneLoader.load_scene(path)`. | MIT; adopted as the sole project base, not yet runtime-verified. |
| BetterTileEditor (`plugins/archives/tile-map/BetterTileEditor-0.1.0.zip`) | Official page documents Godot 4.6+ and testing on 4.6/4.7; patch/forest/scatter and multi-tile object workflows. | GPL-3.0-or-later; defer until tile authoring is needed and obligations accepted. |
| Questify (`plugins/archives/gameplay/Questify-1.6.0.zip`) | Official project page describes graph quests, signals and condition-query integration; default condition polling can be disabled. | MIT; defer. The first quest is a native implementation pending runtime tests. |
| P0nni Inventory System (`p0nni_inventory_system-*.zip`) | Data-driven Resources and editor docks; setup expects an `Inventories` autoload. | MIT; defer until item/inventory model is confirmed. |
| Godot State Charts (`godot-statecharts-*.zip`) | State chart nodes/signals and debug view are available for Godot 4. | MIT; optional, not needed for the first quest flow. |
| GUT (`plugins/archives/testing/Gut-9.6.1.zip`) | GUT 9.x targets Godot 4 and provides GDScript unit testing. | MIT; development-only candidate; Godot is not available here to validate it. |
| gohud (`plugins/archives/ui/gohud-1.2.1.zip`) | Its manifest says officially supported and tested on Godot 4.7+, with HUD, modal, dialog, and quick-slot widgets. | MIT; optional UI candidate, not integrated. |

The template documents that its sample `GlobalState` save format uses `.tres` resources and warns against shared/cloud saves because resource files can contain scripts. The RPG slice stores its own quest, inventory, and position data as versioned JSON in `user://beta3_save.json`; this does not replace the template's independent menu/state behavior.

## Keep for the first foundation prototype

| Archive | Why keep it | Gate before adoption |
| --- | --- | --- |
| `plugins/archives/foundation/Godot-Game-Template-main.zip` | Maaack's template supplies menus, options, pause, credits, scene loading and an example. Its README says Godot 4.7 (4.4+ compatible); it is also listed in `awesome-godot`. | Integrated as the sole template base; verify opening/menu/scene loading and export under the chosen Godot release. |
| `plugins/archives/tile-map/BetterTileEditor-0.1.0.zip` | Relevant 2D terrain/tile authoring tools; its README explicitly says Godot 4.6+ and tested on 4.6/4.7. | Test on the selected engine release and verify it suits our map format and workflow. GPL-3.0-or-later obligations must be acceptable. |
| `plugins/archives/gameplay/Questify-1.6.0.zip` | Godot 4 graph-based quest editor/runtime, directly relevant to RPG authoring and listed in `awesome-godot`. | Build a small quest in a test project; confirm save/load and runtime APIs before tying it to game data. |
| `plugins/archives/gameplay/godot-statecharts-0.22.5.zip` | A focused state-chart library is a plausible reusable building block for event/NPC flow, rather than hand-rolling every state transition. | Confirm engine compatibility, license and actual need in a vertical slice; do not make it a mandatory dependency without that test. |
| `plugins/archives/gameplay/p0nni_inventory_system-0db124e013f07e062f0f4428ca027064e912f60e.zip` | The included README describes a data-driven inventory using Godot Resources and separating logic from UI, a useful match for RPG item data. | Verify Godot version, code/license, save/load behavior and API fit; it is a candidate, not yet the inventory design. |
| `plugins/archives/testing/Gut-9.6.1.zip` | Unit-test tooling supports a maintainable foundation; GUT is listed in `awesome-godot`. | Confirm compatibility with the selected Godot version and use it only for development/test workflows. |

These choices intentionally do **not** add multiple implementations of the same feature. The initial playable RPG loop currently uses native GDScript for quest state and JSON persistence. Add an RPG plugin only when a concrete requirement justifies it.

## Do not use in the first foundation

“Do not use” means exclude from the initial foundation, not that the archive is universally bad. A later decision can change if the genre, target platforms or engine version changes.

### Conflicts with the proposed Godot 4.7 base, stale or redundant RPG tools

| Archive | Reason to leave out now |
| --- | --- |
| `plugins/archives/tile-map/AutotileEditor-8e541f0ffeefccead6d428c4073deaea902d9a9b.zip` | Its README explicitly targets Godot 3.2. RPG Maker tileset conversion is useful, but this archive is not a plug-in-and-play Godot 4.7 foundation; revisit only if ported or tested. |
| `plugins/archives/gameplay/dialogic-b4e38a45a86a05427d26a60fa8dadaab1e1b36f3.zip` | The included README badges Godot 3.4/3.5 and its plugin version is 1.5.1. Do not mistake the current Dialogic project listed in `awesome-godot` for proof that this older archive supports Godot 4.7. |
| `plugins/archives/gameplay/Godot4DialogueEditor-36de4c3a26733f4fe5dd3e906a13bbbf250a507b.zip` | README says it was ported for Godot 4 RC1 (version 0.0.9); its dialogue scope overlaps other candidates and is an old pre-release-era port. |
| `plugins/archives/gameplay/Godot4QuestEditor-1af04bd094911c51c531d72af5645d4bf1f0f0a4.zip` | Overlaps selected Questify and bundles three further editor copies (`dialogue_editor`, `inventory_editor`, `localization_editor`) alongside its own `quest_editor`; README describes an early Godot 4 RC1-era release. Avoid duplicate quest/dialogue/inventory/localization data models. |
| `plugins/archives/gameplay/NodeDialogueEditor-bd04862044d7b40b393a7405c94266dd5bcdd51c.zip` | Another dialogue graph/editor option; not needed alongside a separately selected dialogue solution, and no engine-version evidence has been established for this archive. |
| `plugins/archives/gameplay/Godot4InventoryEditor-99f26c3c9b5d9aa16c3ba95da4c2fd620fff1328.zip` | Editor for inventory data duplicates the inventory authoring surface we should first define around the candidate data-driven runtime; defer until the data model is chosen. |
| `plugins/archives/gameplay/SkillEditor-67d8de17514a74c0d7f99e99e73497c12ad6dd1c.zip` | Specialized skill editor is premature before the combat/skill model is designed; version and license compatibility also need confirmation. |
| `plugins/archives/localization/Godot4LocalizationEditor-9c57a0665b0eb80d5d7f461a519c015714db5bc0.zip` | A second localization authoring workflow is unnecessary for the first slice; defer until localization requirements and CSV/import workflow are defined. |
| `plugins/archives/localization/GodotLocalizationEditor_Plugin.zip` | Duplicates localization-editor choices; do not maintain several editors for one data format. |
| `plugins/archives/localization/LocalizationEditor-e35adcc6ade78619e062232cf598d549fbc6bdfc.zip` | Another overlapping localization editor; keep out until one workflow is selected and tested. |
| `plugins/archives/localization/CSVLocaleEditor-05707b33cb8dbcdec2b17cc38d247a6c4e2ad8ad.zip` | Localization utility overlaps the above options and has no included license file found in the archive scan. |
| `plugins/archives/level-editor/godot-2D-level-editor-9f911b9478105d70aa35965153ca7cba75ebb899.zip` | A separate level-editor workflow is unnecessary before choosing the project's TileMap/map representation; test later against the chosen map model. |
| `plugins/archives/tile-map/Godot-Tile-Pattern-Editor-ecada0b89121a7a7cd5055c07c4adb1101d02545.zip` | Tile pattern editing overlaps the chosen tile/terrain authoring path and has no demonstrated need in the initial slice. |
| `plugins/archives/level-editor/WorldEditor-9abc1a8e199219e245d9eb1cd728a582e4bfb793.zip` | Separate world editor overlaps map/world authoring; defer until its Godot version and data interchange with the selected tile editor are proven. |
| `plugins/archives/level-editor/location-graph-editor-70285fa1133cdd88a36fd6896893faf29eccf23d.zip` | A location graph is optional planning tooling, not a runtime foundation; defer until a graph-based world representation is required. |
| `plugins/archives/level-editor/GodotNode2Tile-80bc6cb5c95a2536bee8bf5834b55447dcf7ae07.zip` | Not needed for the 2D tile workflow; archive inspection identifies it as a 3D-oriented tool. |
### Alternative templates and broad frameworks

| Archive | Reason to leave out now |
| --- | --- |
| `plugins/archives/templates/TakinGodotTemplate-master.zip` | A broad alternative to the selected Maaack template, not something to stack on top; the included README targets Godot 4.4 and it duplicates menus, saves, localization and plugins. Reconsider as an alternative after feature-by-feature comparison. |
| `plugins/archives/templates/godot-game-template-main (1).zip` | A second game-template archive; defer rather than merge two templates and inherit conflicting project conventions before identifying the exact template/version and testing it. |
| `plugins/archives/templates/godot-template-4.x.zip` | Generic alternative template; overlaps the selected starter and has no demonstrated RPG-specific advantage. |
| `plugins/archives/templates/MobileTycoonTemplate_v1.8.1_LITE_Godot.zip` | A complete, opinionated mobile game template rather than a reusable RPG foundation; mobile target is not established. |
| `plugins/archives/templates/Ruake-5b417de7c76ca566efdfb2ab517892bbabb0bfa9.zip` | Bundles GUT and other utilities, duplicating the explicit test-tool choice and increasing bundled code before need is known. |
| `plugins/archives/templates/fuse-v1.1.0.zip` | Broad framework with a large footprint; not justified for the small initial vertical slice and would require a separate architecture/maintenance review. |
| `plugins/archives/level-editor/dioptra-level-editor-27fbc880a184d3f0783267360260488acf8b0d88.zip` | A separate level-editor project, not established as a Godot 4.7 in-project RPG tool; overlaps the selected engine editor workflow. |

### General editor polish, coding aids and utilities (not runtime foundation)

| Archive | Reason to leave out now |
| --- | --- |
| `plugins/archives/editor-tools/AutoSaver-for-Godot-e39510848b76a13e2962a1f8a25a2fe31c5780a9.zip` | Editor convenience only; version/behavior should be tested separately and it does not supply RPG runtime features. |
| `plugins/archives/ui/AutoSizeText-0.4.1.zip` | UI convenience; not required for the initial core and can be replaced by native controls if needed. |
| `plugins/archives/editor-tools/BBCodeEdit-e99091cca17954c0d32bb9521de6010e6470425a.zip` | Archive inspection confirms it bundles two separate addons: `addons/any_icon.editor` (AnyIcon) and `addons/bbcode_edit.editor` (a genuine BBCode editor); it is not solely a misnamed AnyIcon archive. Defer until an actual BBCode-authoring need and license are confirmed. |
| `plugins/archives/editor-tools/CodeEditorSwitch.zip` | Editor-only workflow convenience, unrelated to shipped game functionality. |
| `plugins/archives/editor-tools/DualEditor-24df39d4e7238121fcdee8b7e9d80f03ac7dc294.zip` | Editor-only alternative scripting surface; not needed to build the game foundation. |
| `plugins/archives/editor-tools/Editor-Image-Plugin-2-4fbac0e303e27aa6e1a970fbf684c5c9c6e8d813.zip` | Editor convenience and duplicated by another Editor-Image archive. |
| `plugins/archives/editor-tools/Editor-Image-Plugin-92ec5e7199a3e81a6927e6861396dc02f0469a0c.zip` | Duplicate image-editor plugin; choose at most one after a specific need arises. |
| `plugins/archives/editor-tools/EditorIconExporter-3ff2e7c2031aa1fc267f13b3ffe164b1ecb60f73.zip` | Asset/editor convenience, not a game feature. |
| `plugins/archives/editor-tools/EditorScriptManager-66c842182bc40925e9ecdb693d9f04380b6ea5dc.zip` | Editor workflow utility; postpone until scripts are numerous enough to justify it. |
| `plugins/archives/editor-tools/Editor_Scene_Reload-c3af83a692b215776ee630fff38effd5937d4601.zip` | Editor convenience, not required by the RPG runtime. |
| `plugins/archives/editor-tools/Godot-Fancy-Editor-Sounds-5b41e18e2c7720ad744bbfad055621573159ea6b.zip` | Cosmetic editor preference, no effect on the game foundation. |
| `plugins/archives/editor-tools/GodotEasyEditorButtons-7f3f7297b1e138979bb1db3bd23a559961ab2bbe.zip` | Editor convenience; add only if the development workflow calls for it. |
| `plugins/archives/editor-tools/GodotExternalEditorSettings-7a77d33fafe73fb84509dd43f4a95f4cbe7ea86c.zip` | Configures an external coding workflow, not game behavior. |
| `plugins/archives/editor-tools/GodotOpenInEditor-173acb39dfe29c8c08c3846d262799c353853a9b.zip` | Editor workflow convenience only. |
| `plugins/archives/editor-tools/editor-camera-focus-13c4e7ed843e22304d114c13a4addb5b6b1a093c.zip` | Editor-only camera convenience. |
| `plugins/archives/editor-tools/editor_background-a77443d2932afa25ab6c0fdfe04f65ec98eb3a51.zip` | Cosmetic editor modification. |
| `plugins/archives/editor-tools/evaluate-scene-addon-11d7e633216f6ebb95cd73586246ffe587932e5e.zip` | Editor scene-evaluation utility; defer until a demonstrated editor-side requirement. |
| `plugins/archives/editor-tools/external-shader-editor-1.0.0.zip` | External shader workflow is not needed for the 2D RPG foundation. |
| `plugins/archives/editor-tools/gd.script_editor-e1c688fd6fe284b79dfb164b120d2a1470cf0c53.zip` | Editor replacement/modification is unnecessary and risks changing the team's coding workflow. |
| `plugins/archives/editor-tools/gdterm-5e8595f2c9142478d9efb7b729cb85a07975764f.zip` | Editor terminal utility; no shipped RPG capability. |
| `plugins/archives/editor-tools/godot-editor-log-highlighter-1.0.0.zip` | Cosmetic/editor debugging aid; defer until logs are a workflow problem. |
| `plugins/archives/editor-tools/godot-editor-notes-plugin-main.zip` | Notes dock is a personal/editor convenience, not project foundation. |
| `plugins/archives/editor-tools/godot-editor-theme-explorer-037fecea852cd553fb0a655fecfa6faf95229add.zip` | Theme exploration utility; duplicated by two more snapshots. |
| `plugins/archives/editor-tools/godot-editor-theme-explorer-28310d97bfc9bd4960c7a7776ef8dbb21542817f.zip` | Duplicate theme-explorer snapshot; no need to keep three. |
| `plugins/archives/editor-tools/godot-editor-theme-explorer-c744e08d9e42141e298613515c8274e578fdf304.zip` | Duplicate theme-explorer snapshot; no need to keep three. |
| `plugins/archives/editor-tools/godot-float-script-editor-6445c5ca17e8313e39c0ccae1bb9d7821e7bac82.zip` | Editor scripting convenience only. |
| `plugins/archives/editor-tools/godot-node2d-context-menu-c9a40d924c635f5cd89f0ec4f5277a9139468435.zip` | Editor convenience with no RPG runtime role. |
| `plugins/archives/editor-tools/godot-smart-editor-plugin-d7d7562db1ed762422c2595c2f27ede874300f72.zip` | Broad code-editor modification; defer until a concrete need and compatibility review. |
| `plugins/archives/editor-tools/godot_gdscript_editor_shortcuts-7b903d2bab2746dc73f3286661d15cd2242b8dde.zip` | Editor keyboard convenience only. |
| `plugins/archives/editor-tools/godot_multi_scene_editor-02ca00beaef9d27b03c723746253ba48be1b7daa.zip` | Optional editor layout improvement, not part of a runnable game. |
| `plugins/archives/editor-tools/godot_open_editors-4d883724a7ca06877f2cfd26f3969637b92e63cf.zip` | Editor workflow helper only. |
| `plugins/archives/editor-tools/icon_explorer-1_6_1.zip` | Editor asset browser; defer until icon creation/selection becomes a bottleneck. |
| `plugins/archives/editor-tools/localization-editor-g3-c6054606cd37321d27428f18eae48135fce550fa.zip` | Misnamed Plugin Refresher as previously noted; plugin management convenience is not an RPG feature. |
| `plugins/archives/editor-tools/nano-gdscript-022c201f6be9cff435f5c5fa14d3782ca90da37b.zip` | Alternative syntax/editor support is not needed for the chosen GDScript workflow. |
| `plugins/archives/editor-tools/node-row_v1.0.zip` | Editor presentation customization only. |
| `plugins/archives/editor-tools/pot_word-main.zip` | Editor text/translation convenience; not needed before the localization approach is selected. |
| `plugins/archives/editor-tools/StartRichTextEditor-ac0c1423b9cb48a658e16e7f16bf842bbcef0cb2.zip` | Editor rich-text utility; UI requirements can be assessed in the game rather than installing an editor add-on. |
| `plugins/archives/editor-tools/ToggleExternalEditorPlugin-ecda5eeb4b7d764a02642987c467efb6fd20e18a.zip` | External editor convenience; not a runtime dependency. |
| `plugins/archives/editor-tools/VisualScript-Editor-Extention-116cd655c611bdd0ee588d6b9275de84b0609f42.zip` | VisualScript was removed from Godot 4; incompatible with the proposed base. |
| `plugins/archives/gameplay/guard-editor-for-godot-state-charts-0492d277027bbdc27266be763d4eb686a9808e55.zip` | Optional companion for an unselected visual guard editor; first prove the state-chart library is needed. |
| `plugins/archives/testing/input-audit-lite-0.1.1.zip` | Useful QA audit, but not needed in the runtime foundation; revisit in the testing phase. |
| `plugins/archives/testing/loc-audit-lite-0.1.1.zip` | Useful localization QA, but defer until localization is in scope. |
| `plugins/archives/utilities/log.gd-0.2.2.zip` | Logging utility can be evaluated later; avoid adopting a dependency without a concrete logging requirement. |
| `plugins/archives/ui/app_settings-1_0_1.zip` | Settings utility overlaps the selected template's menus/settings; do not layer two systems. |
| `plugins/archives/ui/settings_menu_lite_v1.0.1.zip` | Settings menu overlaps the selected template's built-in options flow. |
| `plugins/archives/ui/Godot-Input-Remapping-1.6.0.zip` | The selected Maaack template already supplies options/input-related functionality; avoid adding a second settings/input system before checking what is bundled. |
| `plugins/archives/ui/Godot-Options-Menus-1.6.0.zip` | Separate options package duplicates the chosen full template's options menus. |
| `plugins/archives/ui/sweet-settings-v1.0.2.zip` | Alternative settings framework; overlaps the selected template and other settings archives. |
| `plugins/archives/ui/simple-gui-transitions.zip` | UI effect can be implemented or selected later; not a core RPG/editor capability. |
| `plugins/archives/ui/StyleBoxFancy-1.3.5.zip` | Visual styling is not foundational and can conflict with a consistent UI theme. |
| `plugins/archives/ui/UI_Builder_v1.2.0-2.zip` | Editor UI builder is optional tooling; first establish actual menus and game UI requirements. |
| `plugins/archives/ui/markdownlabel_v1.4-2.zip` | Specialized rich-text display not required by the initial game slice. |
| `plugins/archives/ui/godotx_health_bar.zip` | HUD component is too narrow to justify a dependency; build/use only if the combat UI needs it. |

### Nonessential art packs, graphics tools, 3D tools and platform-specific code

| Archive | Reason to leave out now |
| --- | --- |
| `plugins/archives/art/1_Free_Pack.zip` | Art/UI content is not engine foundation; review provenance, license and actual art direction before use. |
| `plugins/archives/art/Card_Game_GFX.zip` | Card-game art is not a match for the assumed RPG; earlier inventory flagged no license file, so do not redistribute/use until rights are clear. |
| `plugins/archives/art/GoldenSkullArt_2D_Iso_Free_Starter_Bundle-2.zip` | Could suit an isometric art direction, which is not yet chosen; review asset license and fit before inclusion. |
| `plugins/archives/art/MorbidEmber_pixel-RPG-starter-pack_v1.1-2.zip` | Potentially relevant art, not a plugin; defer until style, asset provenance and license are confirmed. |
| `plugins/archives/art/natural_lut-2.zip` | Optional visual effect; earlier inventory found no license file, so do not include until rights are established. |
| `plugins/archives/graphics-tools/GraphicsEditor-1fe0e482816a0cb379d6b03a20ac388e7547f9f1.zip` | Separate graphics editor rather than RPG runtime/editor base; increases scope and needs independent maintenance review. |
| `plugins/archives/graphics-tools/HeinImageEditor-1635b1aca81e3ef79ac4d4bc2784935be7cb6038.zip` | In-engine image editor is out of scope for initial RPG-authoring tools; defer unless asset editing inside Godot is a requirement. |
| `plugins/archives/graphics-tools/Sprite-Editor-9cf4590c27ca98e4024050ea9ceaa806de77603e.zip` | Asset authoring tool rather than RPG runtime; choose external art tools or a single sprite editor later. |
| `plugins/archives/graphics-tools/godot-bitmap-editor-2277c153a8d584471c2531c512098906b414af63.zip` | In-editor bitmap editing is not required for gameplay or level authoring. |
| `plugins/archives/graphics-tools/godot-sprite-painter-53555de51a71b8e2df43c020de68cbe9b4c1352d.zip` | Optional in-engine art tool; defer until sprite-painting workflow is explicitly selected. |
| `plugins/archives/graphics-tools/sprite_forge_v1.1.3_fixed.zip` | Specialized graphics tool; not needed for the first playable RPG slice. |
| `plugins/archives/graphics-tools/sprite2d-rect-editor-a4372a2c7895f3da958bccea722e0d0f1c0026ea.zip` | Narrow sprite-authoring editor, not a game foundation. |
| `plugins/archives/graphics-tools/Godot-Vector2ArrayEditorPlugin-43228222c1f96d16629bf20072ed0c3dec72dfd8.zip` | Generic editor for vector resources; no identified RPG requirement. |
| `plugins/archives/graphics-tools/vector2_array_resource_editor-e05b23bf2fec921988382a1d31e32a4b969ea83e.zip` | Duplicate/narrow vector-resource editor; unnecessary without a data-model use case. |
| `plugins/archives/graphics-tools/polygon2d_editor-3eefa7c41c17a98b90dff42efa587989b300a641.zip` | Polygon authoring is not needed for the assumed tile-based RPG. |
| `plugins/archives/graphics-tools/PathEditor-863ac177385587225c2b1075a553d2f03237d744.zip` | Generic path editor; no confirmed navigation or authoring requirement justifies it. |
| `plugins/archives/3d/GDDraw-v0.4.0.zip` | Prior archive inspection identifies this among 3D-oriented tools; not relevant to a 2D RPG foundation. |
| `plugins/archives/3d/Godot-collisionshape3d-editor-dcb48d32d0e4c833016c836caf4436665101ecdd.zip` | 3D collision-shape editor; wrong scope for the assumed 2D project. |
| `plugins/archives/3d/godot-csg-mesh-editor-ada6ff9871b6ea87db054e27bfc80ded6866fa95.zip` | 3D CSG tool; wrong scope. |
| `plugins/archives/3d/material_editor-main.zip` | 3D/material-authoring tool; no need in a 2D tile-based starter. |
| `plugins/archives/3d/mesh-origin-pivot-editor-f14cf7554c4fc7008bfb94cb627aa025621d27b0.zip` | 3D mesh utility; wrong scope. |
| `plugins/archives/3d/terrabrush-0.14.7-alpha.zip` | 3D terrain tool, alpha and native-extension/export complexity; wrong scope for the assumed game. |
| `plugins/archives/3d/gdext_qoi_v7_nnrmal-4.zip` | Native extension adds build/export complexity and does not provide an essential RPG feature. |
| `plugins/archives/utilities/eMessagePipe-v0.3.1.zip` | Native/C# or platform-specific integration is not needed; defer until a concrete messaging requirement and export matrix exist. |
| `plugins/archives/art/cheys-background-addon-345aa8f35a92ba447757e852c5b7effde9ddf552.zip` | Optional background effect, not a game-system dependency. |
| `plugins/archives/utilities/awesome-godot-master.zip` | This is a snapshot/list of resources, not a plugin to run inside the game; use the upstream curated list as a reference. |
| `plugins/archives/utilities/clipboard-narrator-main.zip` | Utility unrelated to RPG creation or runtime. |
| `plugins/archives/templates/Godello-master.zip` | A separate Godot-based Trello-like application, not a game plugin or engine foundation. |

### Remaining data/editor utilities

| Archive | Reason to leave out now |
| --- | --- |
| `plugins/archives/utilities/JSON-Editor-Plugin-for-Godot-4.x-a44f9222144fb02637571a30a3444ad5c5d6c6b7.zip` | Specialized JSON authoring is not needed until the project chooses JSON as its data interchange format; verify maintenance/version if that changes. |
| `plugins/archives/utilities/godot-json-editor-1c3b7b02ae47ccbfcbd522d548c886953a3110e5.zip` | Duplicate JSON-editor option; do not adopt a second editor for a format not yet chosen. |
| `plugins/archives/utilities/Snippets-EditorPlugin-7914c009b57bb1da45a2cfb9182cc2a07eacfbca.zip` | Previous archive review identifies this as Godot 3-era; editor convenience is not worth carrying an unverified legacy addon into the Godot 4 base. |
| `plugins/archives/graphics-tools/Visibility-Collision-Shape-Editor-efae8a47c492afd7039ceda48a5024be0e1ab547.zip` | Narrow editor helper; standard collision-shape editing should suffice until the map/event workflow proves otherwise. |
| `plugins/archives/ui/gohud-1.2.1.zip` | Its manifest requires Godot 4.7+, but it is an optional HUD/UI kit, not the engine/editor foundation; evaluate after the chosen template's UI and target-device needs are known. |
| `plugins/archives/editor-tools/sw-edit-8ec827a132bc44ae383c4b9d217995a3d55ef008.zip` | Alternative text/editor workflow, not a game feature; its role and compatibility need further verification before adoption. |
| `plugins/archives/tile-map/tileseditorbgsettingsplugin-8d7cbafa76e05a5eb38bef82d4fc4daef8829492.zip` | Editor background configuration is cosmetic and does not justify adding an addon to the RPG foundation. |

## Next decision / validation sequence

1. Confirm that Godot 4.7 and desktop-first 2D RPG are acceptable assumptions; Android/Web would change native-extension and UI review.
2. Obtain a readable Drive export/direct download and repeat the same archive, license and compatibility checks for those plugins.
3. With Godot 4.7, import and run the integrated template project; verify the opening/menu flow and that starting a game loads `scenes/world.tscn`.
4. Play-test movement and NPC collision, accept Mira's quest, gather three berries, claim the reward, then restart and verify F5/F9 save/load behavior.
5. Only then test a needed authoring/runtime addon at a time (for example BetterTileEditor for map authoring); check its license, engine support, interactions, and export before adoption.
