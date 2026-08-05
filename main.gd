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
