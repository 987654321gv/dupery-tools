@tool
extends Node
class_name SaveFileditor

const auto_solve:=false
const raw_extract:=false

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
@export_tool_button("export") var export_action = export
@export var crime_scene_pos:Vector2i:
	set(n):
		if n.x<4 and n.y<4 and n.x>=0 and n.y>=0:
			crime_scene_pos=n
@export var board:Array[BoardRole]
@export var other_locations:=[]
@export var quirks:Array[quirks_IDs]:
	set(n):
		if len(n)<len(quirks):
			quirks = n
		else:
			if len(n)>1 and n[len(n)-1] in quirks:
				var quirks_IDs_values = quirks_IDs.values()
				n[len(n)-1] = quirks_IDs_values[quirks_IDs_values.find(n.max())+1] 
			quirks = n
@export var ban_list:Array[BoardRole.roles]
@export var reputation:=5
@export var time:=0
@export_range(0,1,0.00001) var difficulty

@export var raw_data:Dictionary



func import():
	
	options.load(path_options)
	
	if raw_extract:
		raw_data=JSON.parse_string(FileAccess.open(
		options.get_value("saved_values","save_file_path")+"/Dupery.save",
		FileAccess.READ).get_as_text())
		
		return
	var data:Dictionary=JSON.parse_string(FileAccess.open(
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
			#board[-1].role=BoardRole.roles.EMPTY
			
		board.append(BoardRole.new())
		board[-1].configure_from_data(role)
		if auto_solve:
			if board[-1].alignement==1:
				print("evil found : ",int(role["info"]["address"]))
				if board[-1].role==BoardRole.roles.SCOUNDREL:
					print("Warning arrest last !")
			


			


	


func export() -> void:
	options.load(path_options)
	if raw_data:
		FileAccess.open(options.get_value("saved_values","save_file_path")+"/Dupery.save",FileAccess.WRITE).store_string(JSON.stringify(raw_data))
		return
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
	if len(other_locations)==0:
		dict_infos["other_locations"]=""
	else:
		var other_locations_str:PackedStringArray=[]
		for location in other_locations:
			other_locations_str.append(str(location))
		dict_infos["other_locations"]=","+(",".join(other_locations_str))
	dict_infos["quirks"]=quirks
	var available_roles:=[]
	for role in BoardRole.roles.values():
		if role not in ban_list and role != 0:
			available_roles.append(role)
	dict_infos["available_roles"]=available_roles
	print(dict_infos["available_roles"])
	dict_infos["reputation"]=reputation
	dict_infos["time"]=time
	dict_infos["difficulty"]=difficulty
	
	FileAccess.open(options.get_value("saved_values","save_file_path")+"/Dupery.save",FileAccess.WRITE).store_string(ref.format(dict_infos))
