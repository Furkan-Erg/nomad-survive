extends Control

var pizzaCount:int=0
var burgerCount:int=0
var donerCount:int=0
var buyableCount:int=0

@onready var pizzaLabel = $VBoxContainer/PizzaRow/HBoxContainer/PizzaCount
@onready var burgerLabel = $VBoxContainer/BurgerRow/HBoxContainer/BurgerCount
@onready var donerLabel = $VBoxContainer/DonerRow/HBoxContainer/DonerCount
@onready var buyableCountLabel=$VBoxContainer/HBoxContainer/Label
@onready var fridgeMenu = $"../fridge_menu"

signal on_buy(buyList)
signal close_shoplist

func _ready() -> void:
	setBuyableCount()

func setBuyableCount()->void:
	var count=0
	print("yether"+str(fridgeMenu.foodArray))
	for element in fridgeMenu.foodArray:
		if element == "":
			count += 1
			print("buldum "+str(count))
	buyableCount=count
	print("aldım "+str(buyableCount))
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)

func _on_pizza_inc_button_pressed() -> void:
	if buyableCount ==0:
		return
	buyableCount-=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	pizzaCount += 1
	pizzaLabel.text = str(pizzaCount)


func _on_pizza_dec_button_pressed() -> void:
	
	if pizzaCount == 0:
		return
	buyableCount+=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	pizzaCount -= 1
	pizzaLabel.text = str(pizzaCount)

func _on_burger_inc_button_pressed() -> void:
	if buyableCount ==0:
		return
	buyableCount-=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	burgerCount += 1
	burgerLabel.text = str(burgerCount)


func _on_burger_dec_button_pressed() -> void:

	if burgerCount == 0:
		return
	buyableCount+=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	burgerCount -= 1
	burgerLabel.text = str(burgerCount)

func _on_doner_inc_button_pressed() -> void:
	if buyableCount ==0:
		return
	buyableCount-=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	donerCount += 1
	donerLabel.text = str(donerCount)
	

func _on_doner_dec_button_pressed() -> void:
	if donerCount ==0:
		return
	buyableCount+=1
	buyableCountLabel.text="Buyable Count = "+str(buyableCount)
	donerCount -= 1
	donerLabel.text = str(donerCount)


func resetList()-> void:
	pizzaCount = 0
	burgerCount = 0
	donerCount = 0
	pizzaLabel.text = str(pizzaCount)
	burgerLabel.text = str(burgerCount)
	donerLabel.text = str(donerCount)
	setBuyableCount()
	

func _on_reset_button_pressed() -> void:
	resetList()

func _on_buy_button_pressed() -> void:
	
	emit_signal("on_buy",buyList())
	emit_signal("close_shoplist")
	resetList()
	

func _on_button_pressed() -> void:
	emit_signal("close_shoplist")
	resetList()
	

func buyList()->Array:
	var list=[]
	for i in range(burgerCount):
		list.append("burger")
	for i in range(pizzaCount):
		list.append("pizza")
	for i in range(donerCount):
		list.append("doner")
	return list


func _on_fridge_menu_close_fridge_menu() -> void:
	setBuyableCount()
