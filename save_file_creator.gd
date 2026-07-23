@tool
extends Node

var options:=ConfigFile.new()
var path_options="user://options.cfg"

@export_tool_button("import") var import_action = import
@export_tool_button("export") var export_action = _on_button_2_pressed
@export var crime_scene_pos:Vector2i:
	set(n):
		if n.x<4 and n.y<4 and n.x>=0 and n.y>=0:
			crime_scene_pos=n
@export var board:Array[BoardRole]
@export var other_locations:=[]

func import():
	options.load(path_options)
	var data :Dictionary= JSON.parse_string(FileAccess.open(
		options.get_value("saved_values","save_file_path")+"/Dupery.save",
		FileAccess.READ).get_as_text())["data"]["current_case"]["_value"]["Item1"]
	other_locations=[]
	for location in data["board_locations"]:
		if location["location_type"]==0:
			crime_scene_pos=Vector2i(location["board_position"]["Item1"],location["board_position"]["Item2"])
		else:
			other_locations.append(location)
	board=[]
	for role in data["board_roles"]:
		for __ in range(role["info"]["board_position"]["x"]+
						role["info"]["board_position"]["y"]*4-len(board)):
			board.append(BoardRole.new())
			board[-1].role=BoardRole.roles.EMPTY
			
		board.append(BoardRole.new())
		board[-1].role=role["data"]["role"]
		board[-1].unique_data=role["data"]["unique_data"]
		board[-1].alignement=role["info"]["alignment"]
		board[-1].classification=role["info"]["classification"]
		if BoardRole.roles.find_key(board[-1].role) == null:
			print("new role found :",board[-1].role," with data ",
			board[-1].unique_data)
		if board[-1].datas.get(board[-1].role,"") is int:
			print("new role found :",BoardRole.roles.find_key(board[-1].role)," with data ",
			board[-1].unique_data)
			
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
	var address:=1
	var i:int=0
	for role in board:
		if role.role!=0:
			@warning_ignore("integer_division")
			list_str_roles.append(role.get_string(address,Vector2i(i%4,i/4)))
			suspect_list.append(str(role.role))
			address+=1
		i+=1
	dict_infos["roles"]=",".join(list_str_roles)
	dict_infos["suspect_list"]=",".join(suspect_list)
	dict_infos["CrimeScenePos_x"]=crime_scene_pos.x
	dict_infos["CrimeScenePos_y"]=crime_scene_pos.y
	var other_locations_str:PackedStringArray=[]
	for location in other_locations:
		other_locations_str.append(str(location))
	dict_infos["other_locations"]=",".join(other_locations_str)
		
	FileAccess.open(options.get_value("saved_values","save_file_path")+"/Dupery.save",FileAccess.WRITE).store_string(ref.format(dict_infos))
