@tool
class_name BoardRole
extends Resource

const disguise_defaults:={"role":0,"data":"","is_some":false,"ability_used":false}

const dict_names :={10000:"private eye",
					10001:"reporter",
					10002:"romantic",
					10003:"therapist",
					10004:"watherman",
					10005:"blood_hound",
					10006:"priest",
					10007:"skeptic",
					10008:"vigilante",
					10009:"mailman",
					10010:"tailor",
					10011:"doppelganger",
					10012:"partner",
					10013:"mathematician",
					10014:"gossip",
					10015:"clock maker",
					10016:"empath",
					10017:"researcher"
					}

const datas={ roles.PRIVATE_EYE:"-1,0",
			roles.REPORTER:"-1",
			roles.ROMANTIC:"-1,0",
			roles.WEATHERMAN:"-1,-1,-1",
			roles.BLOOD_HOUND:"-1",
			roles.SKEPTIC:"-1",
			roles.VIGILANTE:"-1",
			roles.TAILOR:"-1,-1",
			roles.PARTNER:"-1",
			roles.GOSSIP:"-1",
			roles.CLOCK_MAKER:"-1",
			roles.RESEARCHER:"-1, -1",
			roles.GENTLEMAN:"{}",
			roles.GARGOYLE:'{"no_roles_left":false,"roles_mentioned":[]}',
			roles.JOURNALIST:"{}",
			roles.PUBLISHER:'-1,f',
			roles.BOUNTY_HUNTER:"-1,-1,-1,-1",
			roles.JINX:"-1",
			roles.BELFRY:"-1",
			roles.SAWBONES:"-1",
			roles.PLANT:"20302",
			roles.BARKEEP:"-1",
			roles.SPECTRE:"-1",
			roles.POISONER:"-1",
			roles.CONMAN:"0",
			roles.DETRACTOR:"-1",
			roles.KINGPIN:"-1,-1", #lying, evil
			roles.LANDLORD:"-1", #lock target
			roles.LIBRARIAN:"-1#", # initial_hour-2#target1,target2,target3,
			roles.POLITICIAN:"System.Collections.Generic.List`1[System.Int32]",
			roles.SMOKER:"t", #is rep obscured? t/f
			roles.ARTIST:"-1", #role ID
			roles.HITMAN: "4#", # kill hour#killed_address1,killed_address2,
			roles.GOOD_COP:"-1",
	  roles.FEARMONGER:"0",
			}

const confused := [roles.DRUNKARD,roles.CONMAN]

enum roles {EMPTY=0,
			PRIVATE_EYE=10000,
			REPORTER=10001,
			ROMANTIC=10002,
			THERAPIST=10003,
			WEATHERMAN=10004,
			BLOOD_HOUND=10005,
			PRIEST=10006,
			SKEPTIC=10007,
			VIGILANTE=10008,
			MAILMAN=10009,
			TAILOR=10010,
			DOPPELGANGER=10011,
			PARTNER=10012,
			MATHEMATICIAN=10013,
			GOSSIP=10014,
			CLOCK_MAKER=10015,
			EMPATH=10016,
			RESEARCHER=10017,
			POLITICIAN= 10025,
			LIBRARIAN = 10305,
			TEACHER=10018,
			ARTIST=10019,
			TIPSTER=10021,
			JOURNALIST=10022,
			PUBLISHER=10023,
			GENTLEMAN=10301,
			GARGOYLE=10302,
			HERMIT=10303,
			GOOD_COP=10601,
			SURGEON=20000,
			CHATTER_BOX=20001,
			FALL_GUY=20002,
			YOUNGSTER=20003,
			DRUNKARD=20004,
			COPYCAT=20005,
			BOUNTY_HUNTER=20006,
			MILKMAN=20007,
			WANNABE=20008,
			STALKER=20009,
			JINX=20010,
			BELFRY=20303,
			SAWBONES=20011,
			PLANT=20302,
			BARKEEP=30000,
			CASANOVA=30001,
			MOBSTER=30002,
			SPECTRE=30003,
			SCOUNDREL=30004,
			PREACHER=30005,
			POISONER=30006,
			ACCOUNTANT=30007,
			CONMAN=30008,
			SERIAL_KILLER=30009,
			DETRACTOR = 30011,
			LANDLORD = 30302,
			MAID = 30305,
			SNIPER=30304,
			BAD_COP=30601,
			JUDGE=40000,
			IDOL=40001,
			CRITIC=40002,
			KINGPIN=40003,
			HITMAN=40004,
			RECRUITER=40005,
			FEARMONGER = 40301,
			SMOKER = 40008,
			INVESTOR =40502,
			}
			
const  casino_roles:=[10505,
					10514,
					10515,
					20503,
					30013,
					10506,
					10516,
					20506,
					30507,
					10004,
					10006,
					10501,
					30503,
					40500,
					10517,
					20507,
					30010,
					30014,
					30015,
					10508,
					20508,
					20509,
					30508,
					40504,
					10027,
					10500,
					10507,
					10026,
					10021,
					10511,
					20504,
					20500,
					40009,
					40001,
					30007,
					20002,
					10013,
					40503,
					30501,
					40007,
					20006,
					20012,
					10024
				]

const docks_roles:=[10406,
					10413,
					20002,
					30008,
					40405,
					10410,
					10412,
					20409,
					30407,
					40403,
					10029,
					10030,
					20010,
					30003,
					40400,
					10407,
					20004,
					20401,
					30402,
					30403,
					10416,
					20407,
					30006,
					10014,
					10001,
					10405,
					10402,
					10031,
					20400,
					40402,
					30001,
					20404,
					20013,
					20402,
					30410,
					30005,
					20005,
					10002,
					30405,
					30411,
					10404,
					30000,
					10009,
					20408]
			
const office_roles:=[10002,
					10006,
					10010,
					20004,
					30007,
					10008,
					10016,
					20009,
					20010,
					30008,
					10004,
					10012,
					20005,
					30003,
					10013,
					20006,
					30001,
					30009,
					20000,
					40004,
					10015,
					20001,
					30004,
					40000,
					10005,
					30000,
					40001,
					10001,
					10007,
					30006,
					40002,
					10000,
					20007,
					10011,
					20008,
					30002,
					10017,
					20002,
					10003,
					10009,
					10014,
					10303,
					20301,
					30301,
					30302,
					30303,
					30005,
					40003,
					20003,
					10026,
					10304,
					10602,
					30012,
					30016,
					10019,
					10024,
					20302,
					30010,
					10601,
					30601,
					40006,
					40005,
					40009,
					10018,
					10305,
					20011,
					10301,
					10302,
					20303,
					30305,
					40301,
					10031,
					30304,
					10022,
					10023,
					30011,
					40008,
					10025,
					30013,
					30306,
					40007]
			

enum regions {OFFICE=101,CASINO=111,DOCKS=121}
const dict_roles_in_region := {regions.OFFICE:office_roles,regions.CASINO:casino_roles,regions.DOCKS:docks_roles}
const dict_refs_per_regions:={regions.OFFICE:"res://office_reference.txt",
							  regions.CASINO:"res://casino_reference.txt",
							  regions.DOCKS:"res://docks_reference.txt"}

@export var role:roles=roles.EMPTY:
	set(n):
		role=n
		@warning_ignore("integer_division")
		alignement=(role-10000)/20000
		@warning_ignore("integer_division")
		classification=(role/10000)-1
		if datas.get(role,"") is String:
			unique_data=datas.get(role,"")
		lying=((alignement!=0)!=(role in confused))
		anouncement=""
		
			

@export var unique_data:=""
@export var disguise:BoardRole
@export_group("other")
@export var investigated := false
@export var tainted := false
@export var arrested := false
@export var dead := false
@export var obscured := false
@export var ability_used := false
@export_group("override")
@export_enum("good","evil") var alignement=0
@export_enum("innocent","meddler","underling","traitor") var classification=0
@export var lying := false
@export var anouncement:=""


func get_string(address:int,position:Vector2i)->String:
	var dict_infos:={"role_ID":role,"address":address,"pos_x":position.x,"pos_y":position.y}
	dict_infos["classification"]=classification
	dict_infos["alignment"]=alignement
	dict_infos["unique_data"]=unique_data
	dict_infos["investigated"] = investigated
	dict_infos["tainted"] = tainted
	dict_infos["arrested"] = arrested
	dict_infos["dead"] = dead
	dict_infos["obscured"] = obscured
	dict_infos["lying"] = lying
	dict_infos["ability_used"] = ability_used
	if disguise!=null:
		dict_infos["disguise"]=disguise.get_disguise_text()
	else:
		dict_infos["disguise"]=FileAccess.get_file_as_string("res://Disguise_refernece.txt").format(disguise_defaults)
	dict_infos["anouncement"] = anouncement
	dict_infos["anouncement_overide"] = (anouncement!="")
	
	
	return FileAccess.get_file_as_string("res://Role_reference.txt").format(dict_infos)

func get_disguise_text():
	return FileAccess.get_file_as_string("res://Disguise_refernece.txt").format({"role":role,"data":unique_data,"ability_used":ability_used,"is_some":true})

func configure_from_data(data:Dictionary):
	role=data["data"]["role"]
	unique_data=data["data"]["unique_data"]
	alignement=data["info"]["alignment"]
	classification=data["info"]["classification"]
	investigated=data["info"]["investigated"]
	tainted=data["info"]["tainted"]
	arrested=data["info"]["arrested"]
	dead=data["info"]["dead"]
	obscured=data["info"]["obscured"]
	lying=data["info"]["lying"]
	ability_used=data["data"]["ability_exhausted"]
	if data["disguise"]["_is_some"]:
		disguise=BoardRole.new()
		disguise.role=data["disguise"]["_value"]["role"]
		disguise.unique_data=data["disguise"]["_value"]["unique_data"]
		disguise.ability_used=data["disguise"]["_value"]["ability_exhausted"]
	if data["info"]["info_string"]["_is_some"]:
		anouncement=data["info"]["info_string"]["_value"]
	if roles.find_key(role) == null:
		print("new role found :",role," with data ",unique_data)
	if datas.get(role,"") is int:
		print("new data found :",unique_data," for role ",roles.find_key(role))
	
func get_str_role()->String:
	if role==roles.EMPTY:
		return ""
	elif roles.values().has(role):
		return roles.find_key(role)
	else:
		return str(role)
		
