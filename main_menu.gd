extends Control


func _on_button_pressed() -> void:
	print("start game")
	get_tree().change_scene_to_file("res://game.tscn")


func _on_button_2_pressed() -> void:
	print("options")


func _on_button_3_pressed() -> void:
	print("exit")
	get_tree().quit()
