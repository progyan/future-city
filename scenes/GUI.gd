extends Control

onready var game = get_parent()

func clicked(node):
	if node.quantity == 0:
		return
	var need
	match node.get_index():
		0: need = "greenies"
		1: need = "bread"
		2: need = "tomato"
		3: need = "salad"
		4: need = "sandwich"
		5: need = "burger"
	if not game.need(need):
		return
	node.set_quantity(node.quantity - 1)
	match node.get_index():
		0: 
			game.g -= 1
			game.money += floor(game.g_cost * 1.25)
		1: 
			game.b -= 1
			game.money += floor(game.b_cost * 1.25)
		2: 
			game.t -= 1
			game.money += floor(game.t_cost * 1.25)
		3: 
			game.sal -= 1
			game.money += floor(game.sal_cost * 1.25)
		4: 
			game.san -= 1
			game.money += floor(game.san_cost * 1.25)
		5: 
			game.h -= 1
			game.money += floor(game.h_cost * 1.25)
	game.deliver(need)

func display():
	$ItemList/Bread.set_quantity(game.b)
	$ItemList/Greenies.set_quantity(game.g)
	$ItemList/Tomato.set_quantity(game.t)
	$ItemList/Salad.set_quantity(game.sal)
	$ItemList/Sandwich.set_quantity(game.san)
	$ItemList/Burger.set_quantity(game.h)
	if game.money < 1000:
		$Money.text = str(game.money) + "₽" # здесь рубль но годот блин его не отображает
	else:
		$Money.text = str(floor(game.money / 1000)) + "K₽" # и тута
	$Percent.text = str(game.fun) + "%"
