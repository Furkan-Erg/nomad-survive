class_name ActionObject
extends Node
var nodeName= get_name()
var isEntered:bool=false
signal action_signal(actionType)
func _on_area_2d_body_entered(body: Node2D) -> void:
	isEntered=true


func _on_area_2d_body_exited(body: Node2D) -> void:
	isEntered=false

func _process(delta: float) -> void:
	if isEntered && Input.is_action_pressed("action"):
		isEntered=false
		emitAction(get_name())
		 
	$Label.visible=isEntered

func emitAction(actionType:String)->void:
	emit_signal("action_signal",actionType)
