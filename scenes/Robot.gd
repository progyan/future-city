extends Sprite

var shop_pos = Vector2(46, 71)
var old_pos
onready var game = get_parent().get_parent()
var ki

func random_skin():
	randomize()
	var x = 154 + (randi() % 3) * 17 * 4
	var y = -1 + (randi() % 2) * 17 * 5
	$TShirt.region_rect.position.x = x
	$TShirt.region_rect.position.y = y

func shop():
	game.open_cafe_doors()
	$Delay2.start()
	show()
	$Food.hide()
	old_pos = position

func _ready():
	random_skin()
	shop()

func _on_Tween_tween_completed(object, key):
	randomize()
	if not old_pos:
		game.open_cafe_doors()
	$Delay.start()

func _on_Timer_timeout():
	if old_pos:
		var l = game.starving()
		ki = l[randi() % len(l)]
		var p
		match ki:
			"t": p = "tomato"
			"b": p = "bread"
			"g": p = "greenies"
			"sal": p = "salad"
			"san": p = "sandwich"
			"h": p = "burger"
		$Food.texture = load("res://assets/" + p + ".png")
		$Food.show()
		show()
		$Tween.interpolate_property(self, "position", position, old_pos, 
			position.distance_to(old_pos) / 100, Tween.TRANS_LINEAR, 
			Tween.EASE_IN_OUT)
		$Tween.start()
		old_pos = null
	else:
		shop()

func _on_Delay_timeout():
	hide()
	$Timer.start()
	if not old_pos and game.money >= 370:
		game.buy(ki)

func _on_Delay2_timeout():
	$Tween.interpolate_property(self, "position", position, shop_pos, 
			position.distance_to(shop_pos) / 100, Tween.TRANS_LINEAR, 
			Tween.EASE_IN_OUT)
	$Tween.start()
