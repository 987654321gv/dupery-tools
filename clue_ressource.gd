@tool
extends Resource
class_name ClueResource
@export_enum("Suspect","Surveil","Absolve","Quirk") var type=3
@export var immutable:bool
@export var quirk:SaveFileditor.quirks_IDs
@export var role:BoardRole.roles

func get_save_file_string()->String:
	if type==3:
		return '{"type":3,"immutable":{immutable},"unique_data":"{quirk}"}'.format({"immutable":immutable,"quirk":quirk})
	else:
		return '{"type":{type},"immutable":{immutable},"unique_data":"{role},{type}"}'.format({"immutable":immutable,"type":type,"role":role})
