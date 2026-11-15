@tool
extends Resource
class_name ClueResource
@export_enum("Suspect","Surveil","Absolve","Quirk") var type=3
@export var immutable:bool
@export var quirk:SaveFileditor.quirks_IDs
@export var role:BoardRole.roles

@export_group("Overwrite")
@export var ID_overwite:int
@export_tool_button("Overwrite") var overwrite_action = overwrite

func get_save_file_string()->String:
	if type==3:
		return '{"type":3,"immutable":{immutable},"unique_data":"{quirk}"}'.format({"immutable":immutable,"quirk":quirk})
	else:
		return '{"type":{type},"immutable":{immutable},"unique_data":"{role},{type}"}'.format({"immutable":immutable,"type":type,"role":role})

func overwrite():
	if type==3:
		quirk=ID_overwite as SaveFileditor.quirks_IDs
	else:
		role=ID_overwite as BoardRole.roles
