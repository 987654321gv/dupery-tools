extends Control
class_name RoleEditor

signal exit
signal move_crime_scene
signal add_location(ID:int,unique_data:String)

var role_data:=BoardRole.new():
	set(n):
		role_data=n
		%Role.select(%Role.get_item_index(role_data.role))
		if role_data.role==BoardRole.roles.EMPTY:
			for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
				node.show()
			for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
				node.hide()
			
			#$HFlowContainer/HFlowContainer.hide()
			#$HFlowContainer/FoldableContainer2.hide()
			#$HFlowContainer/FoldableContainer.hide()
			#$HFlowContainer/Button.show()
			#$HFlowContainer/HBoxContainer.show()
		else:
			for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
				node.hide()
			for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
				node.show()
			#$HFlowContainer/HFlowContainer.show()
			#$HFlowContainer/FoldableContainer2.show()
			#$HFlowContainer/FoldableContainer.show()
			#$HFlowContainer/Button.hide()
			#$HFlowContainer/HBoxContainer.hide()
			
		%Investigated.button_pressed=role_data.investigated
		%Tainted.button_pressed=role_data.tainted
		%Arrested.button_pressed=role_data.arrested
		%Dead.button_pressed=role_data.dead
		%Obscured.button_pressed=role_data.obscured
		if role_data.disguise!=null:
			%Disguise.select(%Disguise.get_item_index(role_data.disguise.role))
			%"Disguise Data".text=role_data.disguise.unique_data
		%Allignement.select(role_data.alignement)
		%Classification.select(role_data.classification)
		%Lying.button_pressed=role_data.lying
		%Announcement.text=role_data.anouncement
		%"Unique Data".text=role_data.unique_data
		
		
		
		
		


func _ready() -> void:
	for value in BoardRole.roles.keys():
		%Role.add_item(value,BoardRole.roles[value])
		%Disguise.add_item(value,BoardRole.roles[value])
		
	
		


func _on_option_button_item_selected(index: int) -> void:
	role_data.role=%Role.get_item_id(index)
	if role_data.role==BoardRole.roles.EMPTY:
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
			node.show()
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
			node.hide()
		#$HFlowContainer/HFlowContainer.hide()
		#$HFlowContainer/FoldableContainer2.hide()
		#$HFlowContainer/FoldableContainer.hide()
		#$HFlowContainer/HBoxContainer.show()
		#$HFlowContainer/Button.show()
	else:
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
			node.hide()
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
			node.show()
		#$HFlowContainer/HFlowContainer.show()
		#$HFlowContainer/FoldableContainer2.show()
		#$HFlowContainer/FoldableContainer.show()
		#$HFlowContainer/HBoxContainer.hide()
		#$HFlowContainer/Button.hide()
	%Allignement.select(role_data.alignement)
	%Classification.select(role_data.classification)
	%Lying.button_pressed=role_data.lying
	%Announcement.text=role_data.anouncement
	%"Unique Data".text=role_data.unique_data
	


func _on_exit_pressed() -> void:
	role_data.investigated=%Investigated.button_pressed
	role_data.tainted=%Tainted.button_pressed
	role_data.arrested=%Arrested.button_pressed
	role_data.dead=%Dead.button_pressed
	role_data.obscured=%Obscured.button_pressed
	role_data.alignement=%Allignement.get_selected_id()
	role_data.classification=%Classification.get_selected_id()
	role_data.lying=%Lying.button_pressed
	role_data.anouncement=%Announcement.text
	role_data.unique_data=%"Unique Data".text
	if role_data.disguise!=null:
		role_data.disguise.unique_data=%"Disguise Data".text
	exit.emit()


func _on_disguise_item_selected(index: int) -> void:
	if %Disguise.get_item_id(index)==BoardRole.roles.EMPTY:
		role_data.disguise=null
		%"Disguise Data".text=""
	else:
		if role_data.disguise==null:
			role_data.disguise=BoardRole.new()
		role_data.disguise.role=%Disguise.get_item_id(index)
		%"Disguise Data".text=role_data.disguise.unique_data


func _on_button_pressed() -> void:
	move_crime_scene.emit()
	exit.emit()


func _on_role_from_ID_pressed() -> void:
	if not ($"HFlowContainer/HBoxContainer/ID overrides".text as int):
		return
	role_data.role=$"HFlowContainer/HBoxContainer/ID overrides".text
	%Role.select(%Role.get_item_index(role_data.role))
	if role_data.role==BoardRole.roles.EMPTY:
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
			node.show()
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
			node.hide()
	else:
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when empty"):
			node.hide()
		for node:CanvasItem in get_tree().get_nodes_in_group("shown when filled"):
			node.show()
	%Allignement.select(role_data.alignement)
	%Classification.select(role_data.classification)
	%Lying.button_pressed=role_data.lying
	%Announcement.text=role_data.anouncement
	%"Unique Data".text=role_data.unique_data
	


func _on_add_location_pressed() -> void:
	if not( $HFlowContainer/HBoxContainer2/LineEdit.text as int):
		return
	add_location.emit($HFlowContainer/HBoxContainer2/LineEdit.text as int, $HFlowContainer/HBoxContainer2/LineEdit2.text)
	exit.emit()
