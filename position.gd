extends Button
@export var role_editor_scene: PackedScene

static var window_open:bool = false
var role_data:=BoardRole.new()

func _on_pressed() -> void:
	if window_open: 
		return
	window_open = true
	var role_editor:RoleEditor=role_editor_scene.instantiate()
	var w:=Window.new()
	add_child(w)
	w.add_child(role_editor)
	w.size=Vector2(1000,500)
	w.move_to_center()
	resized.connect(w.move_to_center)
	role_editor.exit.connect(w.queue_free)
	role_editor.exit.connect(on_role_editor_exited)
	role_editor.role_data=role_data
	w.close_requested.connect(role_editor._on_exit_pressed)

func on_role_editor_exited():	
	window_open = false
	if role_data.role==BoardRole.roles.EMPTY:
		text=""
	elif role_data.disguise!=null:
		text="%s (%s)"%[role_data.get_str_role(),role_data.disguise.get_str_role()]
	else:
		text=role_data.get_str_role()
