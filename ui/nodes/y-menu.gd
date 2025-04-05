class_name YMenu extends VBoxContainer

@export var selected_item: int = 0

var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = 0.45
	timer.one_shot = true
	
	update_items()


func _process(delta: float) -> void:
	if Input.is_action_just_released("down") or Input.is_action_just_released("up"):
		timer.stop()
	
	if not timer.is_stopped():
		return
	
	if Input.is_action_pressed("down"):
		select(selected_item + 1)
	elif Input.is_action_pressed("up"):
		select(selected_item - 1)


func select(n: int) -> void:
	timer.start()
	
	var children = get_children()
	selected_item = posmod(n, children.size() - 1)
	update_items()


func update_items() -> void:
	var children = get_children()
	for i in range(children.size()):
		var child = children[i]
		if is_instance_of(child, Label):
			child["theme_override_colors/font_color"] = Colors.ITEM_FOCUSED if i == selected_item else Colors.ITEM_UNFOCUSED
