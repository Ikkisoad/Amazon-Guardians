extends Control
@onready var btn_play = $CenterContainer/VBoxContainer/btnPlay

func _ready():
	btn_play.grab_focus()

func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_btn_about_pressed():
	get_tree().change_scene_to_file("res://scenes/About/about_scene.tscn")


func _on_btn_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits/credits.tscn")
