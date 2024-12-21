extends Control

@onready var slot_0 = $frige_col/HBoxContainer/slot_0
@onready var slot_1 = $frige_col/HBoxContainer2/slot_1
@onready var slot_2 = $frige_col/HBoxContainer3/slot_2

var foodArray := ["", "", ""]
var foodTextures := {
	"pizza": "res://Assets/foods/pizza_dish.png",
	"burger": "res://Assets/foods/burger_dish.png",
	"doner": "res://Assets/foods/doner_dish.png",
	"default": "res://Assets/foods/tabak.png"
}

signal on_eat(selectedFood)
signal close_fridgeMenu

func _ready() -> void:
	setFridge()

func setFridge() -> void:
	var slots = [slot_0, slot_1, slot_2]
	for i in range(len(foodArray)):
		var food = foodArray[i]
		var texture_path = foodTextures.get(food, foodTextures["default"])  
		slots[i].texture_normal = load(texture_path)

func _on_button_pressed() -> void:
	emit_signal("close_fridgeMenu")

func _on_slot_0_pressed() -> void:
	handle_food_selection(0, slot_0)

func _on_slot_1_pressed() -> void:
	handle_food_selection(1, slot_1)

func _on_slot_2_pressed() -> void:
	handle_food_selection(2, slot_2)

func handle_food_selection(index: int, slot) -> void:
	if $"../..".hunger==5:
		return
	emit_signal("on_eat", foodArray[index])
	var tempArray=foodArray
	tempArray[index]=""
	foodArray= tempArray
	slot.texture_normal = load(foodTextures["default"])


func _on_shop_menu_on_buy(buyList:Array) -> void:
	foodArray=replace_empty_with_values(foodArray,buyList)
	setFridge()

func replace_empty_with_values(arrone: Array, arrtwo: Array) -> Array:
	var index = 0
	for i in range(arrone.size()):
		if arrone[i] == "" and index < arrtwo.size():
			arrone[i] = arrtwo[index]
			index += 1
	return arrone
