extends Control

func _ready() -> void:
	hide()
	Global.OnGameOver.connect(GameOver)

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(Global.MENU_SCENE)

func GameOver(playerPos : Vector2) -> void:
	global_position += playerPos
	show()
