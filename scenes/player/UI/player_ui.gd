extends Control

@onready var pb_player_ui = $clPlayerUI/pbPlayerUI
@onready var pb_player_ui_2 = $clPlayerUI/pbPlayerUI2

func updateHUD(p1HP, p2HP):
	pb_player_ui.value = p1HP
	pb_player_ui_2.value = p2HP
