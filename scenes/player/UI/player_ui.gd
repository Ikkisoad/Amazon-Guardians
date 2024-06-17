extends Control

@onready var pb_player_ui = $clPlayerUI/pbPlayerUI
@onready var pb_player_ui_2 = $clPlayerUI/pbPlayerUI2
@onready var lbl_leaf_amount = $clPlayerUI/lblLeafAmount
@onready var lbl_stone_amount = $clPlayerUI/lblStoneAmount
@onready var aspr_resource = $clPlayerUI/asprResource

func updateHUD(p1HP, p2HP, leafAmount = 5, stoneAmount = 5):
	pb_player_ui.value = p1HP
	pb_player_ui_2.value = p2HP
	lbl_leaf_amount.text = str(leafAmount)
	lbl_stone_amount.text = str(stoneAmount)

func changeSelectedResource(selected):
	match selected:
		Global.ResourceType.TREE:
			aspr_resource.play("tree")
		Global.ResourceType.CAVE:
			aspr_resource.play("cave")
