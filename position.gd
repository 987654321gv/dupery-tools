extends Button
@export var role_editor_scene: PackedScene


var role_data:=BoardRole.new()

func _on_pressed() -> void:
	var role_editor:RoleEditor=role_editor_scene.instantiate()
	var w:=Window.new()
	add_child(w)
	w.add_child(role_editor)
	w.size=Vector2(1000,500)
	w.move_to_center()
	w.close_requested.connect(role_editor._on_exit_pressed)
	resized.connect(w.move_to_center)
	role_editor.exit.connect(w.queue_free)
	role_editor.exit.connect(on_role_editor_exited)
	role_editor.role_data=role_data

func on_role_editor_exited():
	if role_data.role==BoardRole.roles.EMPTY:
		text=""
	elif role_data.disguise!=null:
		text="%s (%s)"%[BoardRole.roles.find_key(role_data.role),BoardRole.roles.find_key(role_data.disguise.role)]
	else:
		text=BoardRole.roles.find_key(role_data.role)
		
