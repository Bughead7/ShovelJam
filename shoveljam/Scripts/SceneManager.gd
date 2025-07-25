extends Node2D

#signals
signal transition_out_completed
signal transition_in_completed

#black colorRect for transition animations
var transition_layer: CanvasLayer
var transition_rect: ColorRect
var transition_time: float = 0.5

func _ready() -> void:
	transition_layer = CanvasLayer.new()
	transition_layer.layer = 100 # topmost layer
	transition_rect = ColorRect.new()
	transition_rect.color = Color.BLACK
	# make colorRect fill its parent
	transition_rect.anchor_right = 1.0
	transition_rect.anchor_bottom = 1.0
	#Hide at start then add to scene
	transition_rect.visible = false
	transition_layer.add_child(transition_rect)
	#get_tree().root.add_child(transition_layer)
	
func transition_out(effect: String = "fade"):
	match effect:
		"fade":
			_fade_out()
		"slide":
			_slide_out()
		_:
			_fade_out()
				
func transition_in(effect: String = "fade"):
	match effect:
		"fade":
			_fade_in()
		"slide":
			_slide_in()
		_:
			_fade_in()
				
func _fade_out():
	transition_rect.position = Vector2.ZERO
	transition_rect.modulate.a = 0
	transition_rect.z_index = 999
	transition_rect.visible = true
	
	var tween = create_tween()
	tween.tween_property(transition_rect, "modulate.a", 1.0, transition_time)
	tween.tween_callback(func():
		transition_out_completed.emit()
	)

func _fade_in():
	transition_rect.position = Vector2.ZERO
	transition_rect.modulate.a = 1
	transition_rect.visible = true
	transition_rect.z_index = 999
	
	var tween = create_tween()
	tween.tween_property(transition_rect, "modulate.a", 1.0, transition_time)
	tween.tween_callback(func():
		transition_rect.visible = false
		transition_out_completed.emit()
	)

func _slide_out():
	transition_rect.modulate.a = 1
	transition_rect.visible = true
	transition_rect.z_index = 999
	
	#set initial position to left of the screen
	var viewport_size = get_viewport_rect().size
	transition_rect.position.x = viewport_size.x
	transition_rect.position.y = 0
	var tween = create_tween()
	tween.tween_property(transition_rect, "position:x", 0 , transition_time)
	tween.tween_callback(func(): transition_out_completed.emit())

func _slide_in():
	transition_rect.modulate.a = 1
	transition_rect.visible = true
	transition_rect.z_index = 999
	
	#set initial position to right of the screen
	var viewport_size = get_viewport_rect().size
	transition_rect.position.x = 0
	transition_rect.position.y = 0
	var tween = create_tween()
	tween.tween_property(transition_rect, "position:x", -viewport_size , transition_time)
	tween.tween_callback(func():
		transition_rect.visible = false
		transition_in_completed.emit()
	)
