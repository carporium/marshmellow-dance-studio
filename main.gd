extends Control

class StudioView extends Control:
	signal hotspot_pressed(name: String)

	var mode := "studio"
	var elapsed := 0.0
	var room_level := 1
	var formation := "Line"
	var dancer_count := 3
	var decorations: Array = []
	var routine: Array = []

	func _ready() -> void:
		mouse_filter = Control.MOUSE_FILTER_STOP
		set_process(true)

	func _process(delta: float) -> void:
		elapsed += delta
		queue_redraw()

	func _gui_input(event: InputEvent) -> void:
		if not event is InputEventMouseButton or not event.pressed:
			return
		var point: Vector2 = event.position
		var floor := Rect2(size.x * 0.16, size.y * 0.38, size.x * 0.68, size.y * 0.48)
		var stage := Rect2(size.x * 0.66, size.y * 0.08, size.x * 0.28, size.y * 0.26)
		if stage.has_point(point):
			hotspot_pressed.emit("stage")
		elif floor.has_point(point):
			hotspot_pressed.emit("practice")
		else:
			hotspot_pressed.emit("builder")

	func _draw() -> void:
		var w := size.x
		var h := size.y
		draw_rect(Rect2(Vector2.ZERO, size), Color("#17152b"), true)
		draw_circle(Vector2(w * 0.86, h * 0.1), h * 0.3, Color("#40366d"))
		draw_circle(Vector2(w * 0.08, h * 0.84), h * 0.35, Color("#2a2850"))

		var stage := Rect2(w * 0.66, h * 0.08, w * 0.28, h * 0.26)
		draw_rect(stage, Color("#a64d78"), true)
		draw_rect(stage, Color("#ffd18c"), false, 4)
		draw_line(stage.position + Vector2(0, h * 0.08), stage.position + Vector2(stage.size.x, h * 0.08), Color("#ffe4b2"), 3)
		for light_x in range(4):
			var lx := stage.position.x + stage.size.x * (0.18 + light_x * 0.22)
			draw_circle(Vector2(lx, stage.position.y + 10), 8, Color("#fff0b0"))
			draw_line(Vector2(lx, stage.position.y + 18), Vector2(lx, stage.end.y), Color(1, 0.85, 0.55, 0.2), 2)

		var floor := Rect2(w * 0.16, h * 0.38, w * 0.68, h * 0.48)
		draw_rect(floor, Color("#6a4c73"), true)
		draw_rect(floor, Color("#f3c6a5"), false, 4)
		for index in range(maxi(room_level, 1)):
			var x := floor.position.x + floor.size.x * (0.18 + index * 0.12)
			draw_line(Vector2(x, floor.position.y), Vector2(x, floor.end.y), Color("#8f6b8e"), 2)

		if "Mirrors" in decorations:
			draw_rect(Rect2(w * 0.2, h * 0.12, w * 0.34, h * 0.16), Color("#84b8c2"), true)
			draw_rect(Rect2(w * 0.2, h * 0.12, w * 0.34, h * 0.16), Color("#d6f4e8"), false, 4)
			for mirror_x in range(4):
				var mx := w * 0.22 + mirror_x * w * 0.075
				draw_line(Vector2(mx, h * 0.14), Vector2(mx, h * 0.25), Color(1, 1, 1, 0.25), 2)
		else:
			draw_rect(Rect2(w * 0.2, h * 0.12, w * 0.34, h * 0.16), Color("#453f67"), false, 3)

		if "Barres" in decorations:
			draw_line(Vector2(w * 0.2, h * 0.33), Vector2(w * 0.53, h * 0.33), Color("#e6b07d"), 6)
			draw_line(Vector2(w * 0.22, h * 0.33), Vector2(w * 0.22, h * 0.39), Color("#e6b07d"), 4)
			draw_line(Vector2(w * 0.51, h * 0.33), Vector2(w * 0.51, h * 0.39), Color("#e6b07d"), 4)

		if "Speaker wall" in decorations:
			for speaker_x in range(3):
				var speaker := Rect2(w * 0.56 + speaker_x * w * 0.035, h * 0.19, w * 0.025, h * 0.09)
				draw_rect(speaker, Color("#292337"), true)
				draw_circle(speaker.get_center(), 7, Color("#f5a66f"))

		var positions := _dancer_positions(floor)
		for index in range(dancer_count):
			_draw_dancer(positions[index], index, mode == "rehearsal")

		if mode == "rehearsal":
			var pulse := 0.5 + 0.5 * sin(elapsed * 5.0)
			draw_circle(Vector2(w * 0.8, h * 0.28), 18 + pulse * 8, Color(1, 0.86, 0.48, 0.2))
			draw_circle(Vector2(w * 0.8, h * 0.28), 5, Color("#fff0b0"))

	func _dancer_positions(floor: Rect2) -> Array:
		var center := floor.get_center()
		if formation == "Triangle":
			return [center + Vector2(0, 55), center + Vector2(-105, -35), center + Vector2(105, -35)]
		if formation == "Diamond":
			return [center + Vector2(0, 70), center + Vector2(-115, 0), center + Vector2(115, 0)]
		if formation == "V Formation":
			return [center + Vector2(0, -55), center + Vector2(-125, 45), center + Vector2(125, 45)]
		return [center + Vector2(-125, 0), center, center + Vector2(125, 0)]

	func _draw_dancer(point: Vector2, index: int, moving: bool) -> void:
		var bob := sin(elapsed * 3.0 + index) * (8.0 if moving else 3.0)
		var pose := sin(elapsed * 4.0 + index * 1.7) * (24.0 if moving else 5.0)
		var body := point + Vector2(0, bob)
		var colors := [Color("#ff9d9d"), Color("#8ed8ff"), Color("#b8f28b")]
		var skin := [Color("#ffd0b5"), Color("#c68668"), Color("#f2b28f")]
		draw_circle(body + Vector2(0, -38), 18, skin[index % skin.size()])
		draw_circle(body + Vector2(0, -42), 19, colors[index % colors.size()])
		draw_rect(Rect2(body + Vector2(-15, -20), Vector2(30, 48)), colors[index % colors.size()], true)
		draw_line(body + Vector2(-10, 0), body + Vector2(-24 - pose, 38), colors[index % colors.size()], 8)
		draw_line(body + Vector2(10, 0), body + Vector2(24 + pose, 38), colors[index % colors.size()], 8)
		draw_line(body + Vector2(-11, -7), body + Vector2(-35 - pose, -25), skin[index % skin.size()], 7)
		draw_line(body + Vector2(11, -7), body + Vector2(35 + pose, -25), skin[index % skin.size()], 7)

const DISCIPLINES := ["Jazz", "Lyrical", "Tap", "Ballet", "Contemporary", "Hip Hop", "Acro"]
const MOVES := [
	"Step Touch", "Pivot Turn", "Jazz Square", "Grand Jete",
	"Kick Ball Change", "Chasse", "Reach and Pose", "Body Roll"
]
const FORMATIONS := ["Line", "Triangle", "Diamond", "V Formation"]
const UPGRADES := {
	"Mirrors": 40,
	"Barres": 55,
	"Stage lights": 70,
	"Speaker wall": 85,
}
const SAVE_PATH := "user://studio.json"

var studio_name := "Marshmellow"
var theme_name := "Sunset Peach"
var coins := 100
var students: Array = []
var discipline := "Jazz"
var routine: Array = []
var formation := "Line"
var skills := 0
var company_unlocked := false
var competition_result := ""
var room_level := 1
var decorations: Array = []
var feedback_rating := 0
var feedback_liked := ""
var feedback_confusing := ""
var feedback_next := ""

var root: VBoxContainer
var status: Label
var content: VBoxContainer

func _ready() -> void:
	load_game()
	show_home()
	queue_redraw()

func _draw() -> void:
	var size := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, size), Color("#241b3d"))
	draw_circle(Vector2(size.x * 0.88, size.y * 0.1), size.y * 0.35, Color("#503b72"))
	draw_circle(Vector2(size.x * 0.08, size.y * 0.9), size.y * 0.4, Color("#332653"))
	var floor_rect := Rect2(size.x * 0.08, size.y * 0.62, size.x * 0.84, size.y * 0.24)
	draw_rect(floor_rect, Color("#6a4c73"), true)
	draw_line(floor_rect.position, floor_rect.position + Vector2(floor_rect.size.x, 0), Color("#f3c6a5"), 3)
	for index in range(room_level):
		var x := floor_rect.position.x + floor_rect.size.x * (0.25 + index * 0.15)
		draw_line(Vector2(x, floor_rect.position.y), Vector2(x, floor_rect.end.y), Color("#805f86"), 2)

func clear_screen(title: String) -> void:
	for child in get_children():
		child.queue_free()
	root = VBoxContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("separation", 12)
	root.add_theme_constant_override("margin_left", 32)
	root.add_theme_constant_override("margin_right", 32)
	root.add_theme_constant_override("margin_top", 24)
	root.add_theme_constant_override("margin_bottom", 24)
	add_child(root)

	var heading := Label.new()
	heading.text = title
	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	heading.add_theme_font_size_override("font_size", 32)
	root.add_child(heading)

	status = Label.new()
	status.text = "Studio: %s  |  %s  |  Coins: %d" % [studio_name, theme_name, coins]
	status.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status.add_theme_color_override("font_color", Color("#ffd7a8"))
	root.add_child(status)

	content = VBoxContainer.new()
	content.add_theme_constant_override("separation", 10)
	root.add_child(content)

func add_text(text: String, size := 20) -> void:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", size)
	content.add_child(label)

func add_button(label: String, action: Callable) -> void:
	var button := Button.new()
	button.text = label
	button.custom_minimum_size = Vector2(0, 52)
	button.add_theme_font_size_override("font_size", 19)
	button.pressed.connect(action)
	content.add_child(button)

func add_back() -> void:
	add_button("Back to studio", show_home)

func show_home() -> void:
	clear_screen("MARSHMELLOW DANCE STUDIO")
	add_text("Your studio is open. Tap the room to practice, perform, or build.", 21)
	var studio_view := StudioView.new()
	studio_view.custom_minimum_size = Vector2(0, 390)
	studio_view.room_level = room_level
	studio_view.formation = formation
	studio_view.dancer_count = maxi(students.size(), 3)
	studio_view.decorations = decorations
	studio_view.hotspot_pressed.connect(_studio_hotspot)
	content.add_child(studio_view)
	add_text("Students: %d  |  Skill points: %d  |  Routine counts: %d/8  |  Formation: %s" %
		[students.size(), skills, routine.size(), formation])
	add_text("Studio room level: %d  |  Upgrades: %s" %
		[room_level, ", ".join(decorations) if not decorations.is_empty() else "Practice room"])
	if company_unlocked:
		add_text("COMPANY UNLOCKED — your top dancers can now perform at the advanced level!", 18)
	if not competition_result.is_empty():
		add_text(competition_result, 18)
	add_button("Set up studio", show_setup)
	add_button("Build studio room", show_builder)
	add_button("Students and classes", show_students)
	add_button("Choreography editor", show_choreo)
	add_button("Practice and tuition", practise)
	add_button("Enter competition (20 coins)", compete)
	add_button("Abi's feedback", show_feedback)
	add_button("Save progress", save_and_confirm)

func _studio_hotspot(name: String) -> void:
	if name == "stage":
		rehearse()
	elif name == "practice":
		practise()
	else:
		show_builder()

func show_setup() -> void:
	clear_screen("Studio setup")
	add_text("Choose a name and a colour mood. This is saved only on this device.")
	var name_entry := LineEdit.new()
	name_entry.placeholder_text = "Studio name"
	name_entry.text = studio_name
	name_entry.custom_minimum_size = Vector2(0, 48)
	content.add_child(name_entry)
	add_text("Theme: %s" % theme_name)
	for choice in ["Sunset Peach", "Ocean Blue", "Mint Green"]:
		add_button(choice, func(): _set_theme(choice))
	add_button("Save studio name", func(): _set_name(name_entry.text))
	add_back()

func _set_name(value: String) -> void:
	if not value.strip_edges().is_empty():
		studio_name = value.strip_edges()
	save_game()
	show_home()

func _set_theme(value: String) -> void:
	theme_name = value
	save_game()
	show_setup()

func show_builder() -> void:
	clear_screen("Build your studio")
	add_text("Place upgrades that make your studio feel ready for bigger performances.")
	add_text("ROOM MAP  •  reception  |  practice floor  |  stage lights", 18)
	add_text("Current room level: %d  |  Coins: %d" % [room_level, coins])
	for upgrade in UPGRADES:
		if upgrade in decorations:
			add_button("%s installed" % upgrade, func(): _show_upgrade(upgrade))
		else:
			add_button("Buy %s (%d coins)" % [upgrade, UPGRADES[upgrade]], func(): _buy_upgrade(upgrade))
	add_text("Each installed upgrade expands the room map and improves the studio rating.")
	add_back()

func _show_upgrade(upgrade: String) -> void:
	clear_screen("Studio upgrade")
	add_text("%s is installed in your room." % upgrade)
	add_text("Your dancers can use this space in future stage and class updates.")
	add_back()

func _buy_upgrade(upgrade: String) -> void:
	var cost: int = UPGRADES[upgrade]
	if coins < cost:
		clear_screen("Not enough coins")
		add_text("Practice classes and tuition can earn the %d coins needed for %s." % [cost, upgrade])
		add_back()
		return
	coins -= cost
	decorations.append(upgrade)
	room_level += 1
	save_game()
	show_builder()

func show_students() -> void:
	clear_screen("Students and classes")
	add_text("Discipline: %s" % discipline)
	for student in students:
		add_text("%s — %s | skill %d" % [student["name"], student["class"], student["skill"]], 18)
	if students.is_empty():
		add_text("No students yet. Enrol three dancers to start your first class.")
	if students.size() < 3:
		add_button("Enrol named student %d" % (students.size() + 1), enrol_student)
	for style in DISCIPLINES:
		add_button("Choose %s class" % style, func(): _set_discipline(style))
	add_back()

func enrol_student() -> void:
	var names := ["Maya", "Abi", "Jordan"]
	var index := students.size()
	students.append({"name": names[index], "class": discipline, "skill": 1})
	coins += 15
	save_game()
	show_students()

func _set_discipline(value: String) -> void:
	discipline = value
	save_game()
	show_students()

func show_choreo() -> void:
	clear_screen("Choreography editor — demo moves")
	add_text("Build an 8-count phrase. The full production library is planned; these 8 are distinct demo moves.")
	add_text("Timeline: 00:00 / 02:00  |  8-count phrase: %d/8" % routine.size())
	add_text("Formation: %s (tap a formation to change it)" % formation)
	for move in MOVES:
		var marker := " ✓" if move in routine else ""
		add_button("%s%s" % [move, marker], func(): _toggle_move(move))
	add_text("Stage formations", 18)
	for option in FORMATIONS:
		add_button(option, func(): _set_formation(option))
	add_button("Play rehearsal", rehearse)
	add_button("Replay performance", rehearse)
	add_button("Clear 8-count phrase", clear_routine)
	add_back()

func _toggle_move(move: String) -> void:
	if move in routine:
		routine.erase(move)
	elif routine.size() < 8:
		routine.append(move)
	save_game()
	show_choreo()

func _set_formation(value: String) -> void:
	formation = value
	save_game()
	show_choreo()

func clear_routine() -> void:
	routine.clear()
	save_game()
	show_choreo()

func rehearse() -> void:
	clear_screen("Rehearsal stage")
	add_text("Live rehearsal  •  %s formation  •  %d counts loaded" % [formation, routine.size()], 22)
	var stage_view := StudioView.new()
	stage_view.mode = "rehearsal"
	stage_view.custom_minimum_size = Vector2(0, 430)
	stage_view.formation = formation
	stage_view.dancer_count = maxi(students.size(), 3)
	stage_view.decorations = decorations
	content.add_child(stage_view)
	add_text("The dancers are moving through the rehearsal loop. Build an 8-count routine to choreograph the full phrase.", 18)
	add_button("Replay performance", rehearse)
	add_button("Edit routine", show_choreo)
	add_back()

func practise() -> void:
	clear_screen("Practice and tuition")
	if students.is_empty():
		add_text("Enrol a student before practice.")
		add_back()
		return
	for student in students:
		student["skill"] = int(student["skill"]) + 1
	skills += 1
	coins += students.size() * 10
	save_game()
	add_text("Great work! Every student gained a skill point.")
	add_text("Tuition earned: %d coins" % (students.size() * 10))
	add_button("Practice again", practise)
	add_back()

func compete() -> void:
	if students.size() < 3 or routine.size() < 8 or coins < 20:
		clear_screen("Competition")
		add_text("Before entering, enrol 3 students, complete all 8 counts, and have 20 coins.")
		add_back()
		return
	coins -= 20
	var score := mini(100, 45 + skills * 3 + routine.size() + students.size() * 2)
	var prize := 50 if score >= 65 else 15
	coins += prize
	company_unlocked = company_unlocked or score >= 75
	competition_result = "Competition: %d/100  |  Place: %s  |  Prize: %d coins" % [
		score, "Gold" if score >= 75 else ("Silver" if score >= 60 else "Bronze"), prize]
	save_game()
	show_home()

func show_feedback() -> void:
	clear_screen("Abi's feedback")
	add_text("Nothing is uploaded. Feedback stays local until a parent chooses to share it.")
	add_text("How much did you enjoy it? %s" % ("★".repeat(feedback_rating) if feedback_rating > 0 else "Not rated"))
	for rating in range(1, 6):
		add_button("%d / 5" % rating, func(): _set_rating(rating))
	var liked := LineEdit.new()
	liked.placeholder_text = "What did you like?"
	liked.text = feedback_liked
	content.add_child(liked)
	var confusing := LineEdit.new()
	confusing.placeholder_text = "What was confusing?"
	confusing.text = feedback_confusing
	content.add_child(confusing)
	var next := LineEdit.new()
	next.placeholder_text = "What should we add next?"
	next.text = feedback_next
	content.add_child(next)
	add_button("Save feedback", func(): _save_feedback(liked.text, confusing.text, next.text))
	add_button("Share with parent (copy text)", func(): share_feedback())
	add_back()

func _set_rating(value: int) -> void:
	feedback_rating = value
	show_feedback()

func _save_feedback(liked: String, confusing: String, next: String) -> void:
	feedback_liked = liked
	feedback_confusing = confusing
	feedback_next = next
	save_game()
	show_home()

func share_feedback() -> void:
	var text := "Marshmellow Dance Studio feedback\nEnjoyment: %d/5\nLiked: %s\nConfusing: %s\nNext: %s" % [
		feedback_rating, feedback_liked, feedback_confusing, feedback_next]
	DisplayServer.clipboard_set(text)
	clear_screen("Feedback ready to share")
	add_text("Feedback copied to the device clipboard. A parent can paste it into a message.")
	add_text("The prototype does not upload data or require an account.")
	add_back()

func save_and_confirm() -> void:
	save_game()
	clear_screen("Progress saved")
	add_text("Your studio is saved offline on this device.")
	add_back()

func save_game() -> void:
	var data := {
		"studio_name": studio_name, "theme_name": theme_name, "coins": coins,
		"students": students, "discipline": discipline, "routine": routine,
		"formation": formation, "skills": skills, "company_unlocked": company_unlocked,
		"competition_result": competition_result, "feedback_rating": feedback_rating,
		"room_level": room_level, "decorations": decorations,
		"feedback_liked": feedback_liked, "feedback_confusing": feedback_confusing,
		"feedback_next": feedback_next
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	if typeof(data) != TYPE_DICTIONARY:
		return
	studio_name = str(data.get("studio_name", studio_name))
	theme_name = str(data.get("theme_name", theme_name))
	coins = int(data.get("coins", coins))
	students = data.get("students", students)
	discipline = str(data.get("discipline", discipline))
	routine = data.get("routine", routine)
	formation = str(data.get("formation", formation))
	skills = int(data.get("skills", skills))
	company_unlocked = bool(data.get("company_unlocked", company_unlocked))
	competition_result = str(data.get("competition_result", competition_result))
	feedback_rating = int(data.get("feedback_rating", feedback_rating))
	room_level = int(data.get("room_level", room_level))
	decorations = data.get("decorations", decorations)
	feedback_liked = str(data.get("feedback_liked", feedback_liked))
	feedback_confusing = str(data.get("feedback_confusing", feedback_confusing))
	feedback_next = str(data.get("feedback_next", feedback_next))
