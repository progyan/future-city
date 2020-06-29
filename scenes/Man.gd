extends Sprite

var qu
onready var game = get_parent().get_parent()
var happy = true
export var dump = false
export var top = false
var saying = false
var waiting_order = false

func make_order():
	pass

func emotion(e):
	randomize()
	var m
	if e == 1:
		$Want.hide()
		#print("cba")
		$Emote.show()
		$Wait.stop()
		m = ["faceHappy", "heart"]
		$Say.start()
		#game.dequeue(qu)
		game.review(true)
		if dump:
			happy = false
			$AnimationPlayer.play("change")
	elif e == -1:
		$Want.hide()
		#print("cba")
		$Emote.show()
		m = ["faceAngry", "faceSad", "heartBroken"]
		$Say.start()
		saying = true
		game.dequeue(qu)
		game.review(false)
		happy = false
		$AnimationPlayer.play("change")
	elif e == 0 and happy and not saying and not waiting_order:
		print("abc")
		$Emote.hide()
		$Want.show()
		m = ["_"]
		var d = ["bread", "burger", "salad", "sandwich", "tomato", "greenies"]
		var i = d[randi() % len(d)]
		qu = game.queue(self, i)
		waiting_order = true
		$Want/Food.texture = load("res://assets/" + i + ".png")
		$Wait.start()
		$Say.start()
		saying = true
	else:
		$Emote.hide()
		$Want.hide()
		return
	var i = m[randi() % len(m)]
	$Emote.texture = load("res://assets/emotes/emote_" + i + ".png")

func delivering():
	print(qu)
	game.dequeue(qu)
	waiting_order = false

func happy():
	happy = true

func random_skin():
	randomize()
	var x = 103 + (randi() % 12) * 17
	var y = -1 + (randi() % 10) * 17
	$TShirt.region_rect.position.x = x
	$TShirt.region_rect.position.y = y
	x = 324 + (randi() % 8) * 17
	y = (randi() % 8) * 17
	$Hair.region_rect.position.x = x
	$Hair.region_rect.position.y = y

func _ready():
	random_skin()
	$Want/Pop/Player.play("pop")
	if top:
		$Want.scale.y = -2
		$Want.position.y = 22
		$Want/Food.flip_v = true

func _on_Wait_timeout():
	emotion(-1)

func _on_Say_timeout():
	saying = false
	emotion(-2)
