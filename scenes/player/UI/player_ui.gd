extends Control

@onready var pb_player_ui = $clPlayerUI/pbPlayerUI
@onready var pb_player_ui_2 = $clPlayerUI/pbPlayerUI2
@onready var lbl_leaf_amount = $clPlayerUI/lblLeafAmount

func updateHUD(p1HP, p2HP, leafAmount = 5):
	pb_player_ui.value = p1HP
	pb_player_ui_2.value = p2HP
	lbl_leaf_amount.text = str(leafAmount)
