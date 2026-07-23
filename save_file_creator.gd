@tool
extends Node

var options:=ConfigFile.new()
var path_options="user://options.cfg"

enum quirks_IDs {EVIL_GAZE=0,
				 GOOD_INTUITION=1,
				 DARK_WHISPERS=2,
				 PUBLIC_FAVOUR=4,
				 SHOT_IN_THE_DARK=5,
				 VISIBLE_JUSTICE=6,
				 SWIFT_JUSTICE=7,
				 DEADLY_AIM=8,
				 JEALOUSY=10000,
				 TICKING_CLOCK=10001,
				 MISTY_STREETS=10002,
				 HIDDEN_SMIRK=10003,
				 BAD_INFLUENCES=10004,
				 RADIO_INTERFERENCE=10005,
				 ANTI_AUTHORITARIANISM=10006,
				 MORTAL_DREAD=10009,
				 SETUP=10011,
				 MEDICAL_BREAKTHROUGH=10012,
				 PARANOIA=10013,
				 DIRTY_COP=10014,
				 SILENT_ACCOMPLICE=10015,
				 INSIDER_LOYALTY=10016,
				 OUTSIDER_LOYALTY=10017,
				 UNHOLY_LAND=10018,
				 SHRINK=10019,
				 THAT_SMILE=10020,
				 HAUNTED=10021,
				 PERFECT_CRIME=10022,
				 EVIL_SUSPECTS=10023,
				 BROKEN_CLOCK=10024,
				 FAULTY_CLOCK=10025,
				 BROKEN_RADIO=10026}


@export_tool_button("import") var import_action = import
@export_tool_button("export") var export_action = _on_button_2_pressed
@export var crime_scene_pos:Vector2i:
	set(n):
		if n.x<4 and n.y<4 and n.x>=0 and n.y>=0:
			crime_scene_pos=n
@export var board:Array[BoardRole]
@export var other_locations:=[]
@export var quirks:Array[quirks_IDs]
func import():
	
	options.load(path_options)
	var data :Dictionary= JSON.parse_string(FileAccess.open(
		options.get_value("saved_values","save_file_path")+"/Dupery.save",
		FileAccess.READ).get_as_text())["data"]["current_case"]["_value"]["Item1"]
	quirks=[]
	for quirk in data["active_case_quirks"]:
		quirks.append(quirk)
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
		if role["disguise"]["_is_some"]:
			board[-1].disguise=BoardRole.new()
			board[-1].disguise.role=role["disguise"]["_value"]["role"]
			board[-1].disguise.unique_data=role["disguise"]["_value"]["unique_data"]
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
	dict_infos["quirks"]=quirks
		
	FileAccess.open(options.get_value("saved_values","save_file_path")+"/Dupery.save",FileAccess.WRITE).store_string(ref.format(dict_infos))
