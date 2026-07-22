@tool
extends Node

var options:=ConfigFile.new()
var path_options="user://options.cfg"

@export_tool_button("import") var import_action = import

@export var board:Array[BoardRole]


func import():
	options.load(path_options)
	var data :Array= JSON.parse_string(FileAccess.open(
		options.get_value("saved_values","save_file_path")+"/Dupery.save",
		FileAccess.READ).get_as_text())["data"]["current_case"]["_value"][
			"Item1"]["board_roles"]
	board=[]
	for role in data:
		board.append(BoardRole.new())
		board[-1].role=role["data"]["role"]
		board[-1].unique_data=role["data"]["unique_data"]
		board[-1].alignement=role["info"]["alignment"]
		board[-1].classification=role["info"]["classification"]
		pass
	print(data)
	

func _on_file_dialog_dir_selected(dir: String) -> void:
	options.set_value("saved_values","save_file_path",dir)
	options.save(path_options)

func _on_button_pressed() -> void:
	$FileDialog.show()
	


func _on_button_2_pressed() -> void:
	options.load(path_options)
	var ref := FileAccess.get_file_as_string("res://reference.txt")
	var list_str_roles:PackedStringArray=[]
	var suspect_list:PackedStringArray=[]
	var dict_infos:={}
	
	var i:int=0
	for role in board:
		@warning_ignore("integer_division")
		list_str_roles.append(role.get_string(i+1,Vector2i(i%4,i/4)))
		suspect_list.append(str(role.role))
		i+=1
	dict_infos["roles"]=",".join(list_str_roles)
	dict_infos["suspect_list"]=",".join(suspect_list)
	
	FileAccess.open(options.get_value("saved_values","save_file_path")+"/Dupery.save",FileAccess.WRITE).store_string(ref.format(dict_infos))
