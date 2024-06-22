extends Control

func _ready() -> void:
	hide()
	Global.OnStageWin.connect(NextStage)

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	Global.nextStage()

func NextStage() -> void:
	Global.currentStage += 1
	show()
	get_tree().paused = true;
