extends Control

const DISCIPLINES = ["Jazz", "Lyrical", "Tap", "Ballet", "Contemporary", "Hip Hop", "Acro"]
const MOVES = ["Step Touch", "Pivot", "Turn", "Leap", "Kick", "Slide", "Reach", "Pose"]
const SAVE_PATH = "user://studio.json"
var studio_name = "Marshmellow"
var coins = 100
var students: Array = []
var discipline = "Jazz"
var routine: Array = []
var skills = 0
var feedback = ""
var output: Label
var root: VBoxContainer

func _ready() -> void:
	load_game()
	show_home()

func clear_screen() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
	root = VBoxContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("separation", 10)
	add_child(root)
	var title = Label.new()
	title.text = "MARSHMELLOW DANCE STUDIO"
	title.add_theme_font_size_override("font_size", 34)
	root.add_child(title)
	output = Label.new()
	output.add_theme_font_size_override("font_size", 22)
	root.add_child(output)

func btn(label: String, action: Callable) -> void:
	var b = Button.new()
	b.text = label
	b.custom_minimum_size = Vector2(0, 48)
	b.pressed.connect(action)
	root.add_child(b)

func show_home() -> void:
	clear_screen()
	output.text = "Studio: %s | Coins: %d | Students: %d | Skill: %d\nPrototype: text-based gameplay; 3D animation is not implemented." % [studio_name, coins, students.size(), skills]
	btn("Enrol Student", enrol)
	btn("Choose Dance Style", choose_style)
	btn("Choreograph", show_choreo)
	btn("Practise", practise)
	btn("Enter Competition (20 coins)", compete)
	btn("Abi's Feedback", show_feedback)
	btn("Save", save_game)

func enrol() -> void:
	students.append("Dancer %d" % (students.size() + 1))
	coins += 15
	save_game()
	show_home()

func choose_style() -> void:
	clear_screen()
	output.text = "Choose a class"
	for style in DISCIPLINES:
		btn(style, func(): discipline = style; save_game(); show_home())
	btn("Back", show_home)

func show_choreo() -> void:
	clear_screen()
	output.text = "%s routine: %s\nTap moves to add to your sequence." % [discipline, ", ".join(routine)]
	for move in MOVES:
		btn(move, func(): routine.append(move); save_game(); show_choreo())
	btn("Rehearse routine", rehearse)
	btn("Clear routine", func(): routine.clear(); save_game(); show_choreo())
	btn("Back", show_home)

func rehearse() -> void:
	output.text = "Rehearsal (sequence preview only):\n" + " → ".join(routine)

func practise() -> void:
	if students.is_empty():
		output.text = "Enrol a student first!"
		return
	skills += 1
	coins += 10
	save_game()
	show_home()

func compete() -> void:
	if coins < 20 or routine.is_empty() or students.is_empty():
		output.text = "Need 20 coins, a student and a routine."
		return
	coins -= 20
	var score = mini(100, 30 + skills * 5 + routine.size() * 2)
	if score >= 60:
		coins += 50
	save_game()
	show_home()
	output.text += "\nCompetition score: %d/100. %s" % [score, "Prize: 50 coins!" if score >= 60 else "Keep practising!"]

func show_feedback() -> void:
	clear_screen()
	output.text = "Abi, what should we improve?"
	var entry = TextEdit.new()
	entry.custom_minimum_size = Vector2(0, 180)
	entry.text = feedback
	root.add_child(entry)
	btn("Save Feedback", func(): feedback = entry.text; save_game(); show_home())
	btn("Back", show_home)

func save_game() -> void:
	var data = {"studio_name": studio_name, "coins": coins, "students": students, "discipline": discipline, "routine": routine, "skills": skills, "feedback": feedback}
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(data))

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(f.get_as_text())
	if typeof(data) != TYPE_DICTIONARY:
		return
	studio_name = str(data.get("studio_name", studio_name))
	coins = int(data.get("coins", coins))
	students = data.get("students", [])
	discipline = str(data.get("discipline", discipline))
	routine = data.get("routine", [])
	skills = int(data.get("skills", skills))
	feedback = str(data.get("feedback", feedback))
