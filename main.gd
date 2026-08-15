extends Control
var options:=ConfigFile.new()
var path_options="user://options.cfg"

@onready var position_button = preload("res://Position.tscn")
@onready var save_file_editor:SaveFileditor = $SaveFileditor
@onready var file_dialog = $FileDialog
@onready var main_grid = $VBoxContainer/GridContainer

func _ready() -> void:
	options.load(path_options)
	file_dialog.move_to_center()
	resized.connect(file_dialog.move_to_center)
	main_grid.columns=save_file_editor.board_size.x
	for i in range(save_file_editor.board_size.x * save_file_editor.board_size.y):
		var position_role:Button = position_button.instantiate()
		position_role.role_data=BoardRole.new()
		save_file_editor.board.append(position_role.role_data)
		position_role.move_crime_scene.connect(move_crime_scene.bind(position_role))
		if (i==0):
			position_role.disabled = true
		main_grid.add_child(position_role)
func _on_select_dir_pressed() -> void:
	file_dialog.show()
func _on_file_dialog_dir_selected(dir: String) -> void:
	options.set_value("saved_values","save_file_path",dir)
	options.save(path_options)


func _on_export_pressed() -> void:
	save_file_editor.export()
	print("export successful!")

func get_position_from_vector(pos_vector:Vector2i)->Button:
	return main_grid.get_child(pos_vector.x+(pos_vector.y*4))
func _on_import_pressed() -> void:
	get_position_from_vector(save_file_editor.crime_scene_pos).disabled=false
	save_file_editor.import()
	get_position_from_vector(save_file_editor.crime_scene_pos).disabled=true
	for __ in range(16-len(save_file_editor.board)):
		save_file_editor.board.append(BoardRole.new())
	for index in range(16):
		main_grid.get_child(index).role_data=save_file_editor.board[index]
		main_grid.get_child(index).on_role_editor_exited()
		
func move_crime_scene(position_role):
	get_position_from_vector(save_file_editor.crime_scene_pos).disabled=false
	var pos=main_grid.get_children().find(position_role)
	@warning_ignore("integer_division")
	save_file_editor.crime_scene_pos=Vector2i(pos%4,pos/4)
	get_position_from_vector(save_file_editor.crime_scene_pos).disabled=true
	
