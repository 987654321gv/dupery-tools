@tool
class_name BoardRole
extends Resource



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


enum roles {PRIVATE_EYE=10000,
			REPORTER=10001,
			ROMANTIC=10002,
			THERAPIST=10003,
			WATHERMAN=10004,
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
		
@export_enum("good","evil") var alignement=0
@export_enum("innocent","meddler","underling","traitor") var classification=0
@export var unique_data:=""

func get_string(address:int,position:Vector2i)->String:
	var dict_infos:={"role_ID":role,"address":address,"pos_x":position.x,"pos_y":position.y}
	@warning_ignore("integer_division")
	dict_infos["classification"]=classification
	@warning_ignore("integer_division")
	dict_infos["alignment"]=alignement
	dict_infos["unique_data"]=unique_data
	return FileAccess.get_file_as_string("res://Role_reference.txt").format(dict_infos)
