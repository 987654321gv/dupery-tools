@tool
class_name BoardRole
extends Resource

const disguise_defaults:={"role":0,"data":"","is_some":false}

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
					10017:"researcher"}

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
			roles.RESEARCHER:"-1",
			roles.GENTLEMAN:"{}",
			roles.GARGOYLE:'{"no_roles_left":false,"roles_mentioned":[]}',
			roles.BOUNTY_HUNTER:"-1,-1,-1,-1",
			roles.JINX:"-1",
			roles.BELFRY:"-1",
			roles.BARKEEP:"-1",
			roles.SPECTRE:"-1",
			roles.POISONER:"-1",
			roles.CONMAN:"0",
			roles.KINGPIN:"-1,-1"}

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
			GENTLEMAN=10301,
			GARGOYLE=10302,
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
			JUDGE=40000,
			IDOL=40001,
			CRITIC=40002,
			KINGPIN=40003,
			HITMAN=40004,
			RECRUITER=40005}
			

			
@export var role:roles=roles.PRIVATE_EYE:
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
	if disguise!=null:
		dict_infos["disguise"]=disguise.get_disguise_text()
	else:
		dict_infos["disguise"]=FileAccess.get_file_as_string("res://Disguise_refernece.txt").format(disguise_defaults)
	dict_infos["anouncement"] = anouncement
	dict_infos["anouncement_overide"] = (anouncement!="")
	
	
	return FileAccess.get_file_as_string("res://Role_reference.txt").format(dict_infos)

func get_disguise_text():
	return FileAccess.get_file_as_string("res://Disguise_refernece.txt").format({"role":role,"data":unique_data,"is_some":true})

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
	if data["disguise"]["_is_some"]:
		disguise=BoardRole.new()
		disguise.role=data["disguise"]["_value"]["role"]
		disguise.unique_data=data["disguise"]["_value"]["unique_data"]
	if data["info"]["info_string"]["_is_some"]:
		anouncement=data["info"]["info_string"]["_value"]
	if roles.find_key(role) == null:
		print("new role found :",role," with data ",unique_data)
	if datas.get(role,"") is int:
		print("new data found :",unique_data," for role ",roles.find_key(role))
	
