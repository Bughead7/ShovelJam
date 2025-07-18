extends Node2D

@onready var sprite = $Sprite2D

const CHARACTER_IMAGE = {
	"Penni": preload("res://Assets/mc_standard_sprite.PNG"),
	"Speaking": preload("res://Assets/mc_standartsprite_speaking.PNG"),
	"Sad": preload("res://Assets/mc_sadsprite.PNG"),
	"SadSpeaking": preload("res://Assets/mc_sadsprite_speaking.PNG")
	}
func _ready():
	pass


func change_character(character_name : String, speaking: bool = false, sad: bool = true, sad_speaking: bool = false):
	sprite.texture = CHARACTER_IMAGE[character_name]
	if speaking:
		$Sprite2D.texture=ResourceLoader.load("res://Assets/mc_standartsprite_speaking.PNG")
	if sad:		
		$Sprite2D.texture=ResourceLoader.load("res://Assets/mc_sadsprite.PNG")
	if sad_speaking:
		$Sprite2D.texture=ResourceLoader.load("res://Assets/mc_sadsprite_speaking.PNG")
	else:
		$Sprite2D.texture=ResourceLoader.load("res://Assets/mc_standard_sprite.PNG")
	
