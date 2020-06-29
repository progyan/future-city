extends TextureRect

onready var gui = get_tree().get_root().find_node("GUI", true, false)
var quantity = 0

func set_quantity(q):
	quantity = q
	$Quantity.text = str(q)

func _on_Item_gui_input(event):
	if event.is_pressed():
		gui.clicked(self)
