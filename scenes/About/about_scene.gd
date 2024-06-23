extends Control


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_btn_keep_playing_pressed():
	Global.currentStage += 1
	Global.nextStage()
