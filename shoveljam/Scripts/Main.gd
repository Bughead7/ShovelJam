extends Node2D

@onready var dialog_ui = %DialogUI
@onready var character = %Character

var dialog_index : int = 0
const dialog_lines : Array[String] = [
	"Penni: Hello, welcome to the Bakery! What can I help you with today?",
	"Speaking: Hey there, I need a dozen cupcakes and one sheet cake please AAAAAAAAAHHHHHHHHHHHHHH.", 
	"Penni: That'll be $24.50",
	"SadSpeaking: Jeez, thats quite steep...",
]
func _ready():
	#process first line of dialog
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index+= 1
				process_current_line()

func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2 )
	return {
		"speaker_name": line_info[0],
		"dialog_line": line_info[1]
	}
	
func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	dialog_ui.change_line(line_info["speaker_name"], line_info["dialog_line"])
	character.change_character(line_info["speaker_name"])
