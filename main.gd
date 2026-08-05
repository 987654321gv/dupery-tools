extends Control
var options:=ConfigFile.new()
var path_options="user://options.cfg"



func _ready() -> void:
	options.load(path_options)
	$FileDialog.move_to_center()
	resized.connect($FileDialog.move_to_center)
	for position_role in $VBoxContainer/GridContainer.get_children():
		position_role.role_data=BoardRole.new()
		$SaveFileditor.board.append(position_role.role_data)
func _on_select_dir_pressed() -> void:
	$FileDialog.show()
func _on_file_dialog_dir_selected(dir: String) -> void:
	options.set_value("saved_values","save_file_path",dir)
	options.save(path_options)


func _on_export_pressed() -> void:
	$SaveFileditor.export()
	print("export successful!")

func get_position_from_vector(pos_vector:Vector2i)->Button:
	return $VBoxContainer/GridContainer.get_child(pos_vector.x+(pos_vector.y*4))
func _on_import_pressed() -> void:
	get_position_from_vector($SaveFileditor.crime_scene_pos).disabled=false
	$SaveFileditor.import()
	get_position_from_vector($SaveFileditor.crime_scene_pos).disabled=true
	for __ in range(16-len($SaveFileditor.board)):
		$SaveFileditor.board.append(BoardRole.new())
	for index in range(16):
		$VBoxContainer/GridContainer.get_child(index).role_data=$SaveFileditor.board[index]
		$VBoxContainer/GridContainer.get_child(index).on_role_editor_exited()
		
