extends Node2D

@onready var start_button: Button = %StartButton

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	
