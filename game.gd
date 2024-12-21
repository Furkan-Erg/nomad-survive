extends Node2D



@onready var healthBar:ProgressBar = $CanvasLayer/HealthBar
@onready var hungerBar:ProgressBar = $CanvasLayer/HungerBar
@onready var thirstBar:ProgressBar = $CanvasLayer/ThirstBar
@onready var sleepBar:ProgressBar = $CanvasLayer/SleepBar


var health : int = 5
var hunger : int = 5
var thirst : int = 5
var sleep : int = 5
const Enums = preload("res://enums.gd")
var gameState : int = Enums.GameStates.PLAYING


var foods := {
	"pizza": 2,
	"burger": 3,
	"doner": 1,
}




func _process(delta: float) -> void:
	setBars()


func setBars() -> void:
	healthBar.value = health
	hungerBar.value = hunger
	thirstBar.value = thirst
	sleepBar.value = sleep



# Setter fonksiyonları
func set_health(value: int) -> void:
	if health == 0:
		gameState = Enums.GameStates.GAME_OVER
	health += value
	healthBar.value = health

func set_hunger(value: int) -> void:
	if value < 0 && hunger == 0:
		return
	if value > 0 && hunger == 5:
		return
	if hunger <= 0:
		set_health(-1)
		return
	hunger += value
	if hunger >5 :
		hunger =5
	hungerBar.value = hunger

func set_thirst(value: int) -> void:
	if value < 0 && thirst == 0:
		return
	if value > 0 && thirst == 5:
		return
	if thirst <= 0:
		set_health(-1)
		return
	thirst += value
	thirstBar.value = thirst
	

func set_sleep(value: int) -> void:
	if sleep <= 0:
		set_health(-1)
		return
	sleep += value
	sleepBar.value = sleep
	


func _on_bed_action_signal(actionType) -> void:
	print(actionType)


func _on_fridge_action_signal(actionType) -> void:
	print(actionType)
	if gameState == Enums.GameStates.PLAYING:
		gameState = Enums.GameStates.PAUSED
		$CanvasLayer/fridge_menu.visible=true
	else:
		gameState=Enums.GameStates.PLAYING
		$CanvasLayer/fridge_menu.visible=false


func _on_computer_action_signal(actionType) -> void:
	print(actionType)
	


func _on_water_dispenser_action_signal(actionType) -> void:
	set_thirst(1)


func _on_shop_list_action_signal(actionType) -> void:
	if gameState == Enums.GameStates.PLAYING:
		gameState = Enums.GameStates.PAUSED
		$CanvasLayer/ShopMenu.visible=true
	else:
		gameState=Enums.GameStates.PLAYING
		$CanvasLayer/ShopMenu.visible=false


func _on_shop_menu_on_buy() -> void:
	print("buyladım para azalt sadece")


func _on_shop_menu_close_shoplist() -> void:
	gameState=Enums.GameStates.PLAYING
	$CanvasLayer/ShopMenu.visible=false

func _on_fridge_menu_on_eat(selectedFood) -> void:
	set_hunger(foods[selectedFood])


func _on_fridge_menu_close_fridge_menu() -> void:
	gameState=Enums.GameStates.PLAYING
	$CanvasLayer/fridge_menu.visible=false
