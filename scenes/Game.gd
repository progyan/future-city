extends Node2D

var money = 1000
var rew = []
var fun = 100
var g = 1
var b = 1
var t = 1
var sal = 1
var san = 1
var h = 1
const g_cost = 70
const b_cost = 35
const t_cost = 40
const sal_cost = 140
const san_cost = 190
const h_cost = 370
var qu = []
onready var drone = preload("res://scenes/Drone.tscn")
var comp = 20
onready var robot = preload("res://scenes/Robot.tscn")

func refun():
	var f = 0.0
	for r in rew:
		if r:
			f += 1.0
	fun = floor(f / len(rew) * 100.0)
	$GUI.display()

func buy(type):
	match type:
		"g": 
			if money >= g_cost:
				g += 1
				money -= g_cost
		"b": 
			if money >= b_cost:
				b += 1
				money -= b_cost
		"t": 
			if money >= t_cost:
				t += 1
				money -= t_cost
		"sal": 
			if money >= sal_cost:
				sal += 1
				money -= sal_cost
		"san": 
			if money >= san_cost:
				san += 1
				money -= san_cost
		"h": 
			if money >= h_cost:
				h += 1
				money -= h_cost
	$GUI.display()

func _ready():
	for man in $Men.get_children():
		man.emotion(-2)
	$GUI.display()
	$BGM.play()

func _on_Queue_timeout():
	randomize()
	for i in range(floor(comp / 20.0)):
		$Men.get_child(randi() % 5).emotion(0)
	comp += 1 
	if comp % 20 == 0:
		var r = robot.instance()
		r.position = Vector2(198, 166)
		$Robots.add_child(r)

func need(sth):
	for i in qu:
		if i[1] == sth:
			return true
	return false

func deliver(sth):
	for i in qu:
		if i[1] == sth:
			i[0].delivering()
			var d = drone.instance()
			d.position = Vector2(238, 168)
			$Drones.add_child(d)
			d.delivery(i[0], i[1])
			return

func queue(obj, i):
	qu.append([obj, i])
	print("Enqueue", qu)
	print('------------------------------------------------')
	return len(qu) - 1

func dequeue(id):
	qu[id] = [null, null]
	print("Dqueue", qu)
	print('------------------------------------------------')

func review(good):
	rew.append(good)
	if len(rew) > 16:
		rew.remove(0)
	refun()

func open_cafe_doors():
	$Decor/AnimationPlayer.play("OpenCafe")

func close_cafe_doors():
	$Decor/AnimationPlayer.play_backwards("OpenCafe")

func starving():
	var ans = []
	if b < 1:
		ans.append("b")
	if t < 1:
		ans.append("t")
	if g < 1:
		ans.append("g")
	if sal < 1:
		ans.append("sal")
	if san < 1:
		ans.append("san")
	if h < 1:
		ans.append("h")
	if len(ans) > 0:
		return ans
	else:
		return ["b", "h", "sal", "san", "t", "g"]
