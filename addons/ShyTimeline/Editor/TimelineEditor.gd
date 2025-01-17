extends Control
tool

onready var graph = $VBox/HSplitContainer/GraphEdit
onready var text_edit = $VBox/HSplitContainer/TextEditor
onready var global_vars_button = $VBox/HBoxContainer/GlobalVars

onready var timeline: Resource setget set_timeline
var selected_event : Object


func _ready() -> void:
	if !Engine.editor_hint:
		set_timeline(load("res://ExampleTimeline.tres"))


func set_timeline(new) -> void:
	if new and new != timeline:
		graph.clear()
		timeline = new
		graph.load_timeline(timeline)


func _on_GraphEdit_node_selected(node: Node) -> void:
	text_edit.visible = false
	selected_event = node.event
	if selected_event.get_event_type() == "TextEvent":
		text_edit.event = selected_event
		text_edit.visible = true


func _on_GlobalVars_pressed() -> void:
	var tmp = EditorPlugin.new()
	#tmp.get_editor_interface().edit_node(TimelineVars)


func _on_GraphEdit_node_unselected(node: Node) -> void:
	if selected_event == node.event:
		selected_event = null
		text_edit.visible = false
