extends AnimatedSprite

var old_pos
var old_man

func delivery(man, thing):
	var pos = man.position
	old_man = man
	#man.delivering()
	$Food.texture = load("res://assets/" + thing + ".png")
	$Food.show()
	old_pos = position
	$Tween.interpolate_property(self, "position", position, pos, 
			position.distance_to(pos) / 100, Tween.TRANS_LINEAR, 
			Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	if old_pos:
		$Food.hide()
		old_man.emotion(1)
		play("default")
		$Tween.interpolate_property(self, "position", position, old_pos, 
			position.distance_to(old_pos) / 100, Tween.TRANS_LINEAR, 
			Tween.EASE_IN_OUT)
		$Tween.start()
		old_pos = null
	else:
		queue_free()
