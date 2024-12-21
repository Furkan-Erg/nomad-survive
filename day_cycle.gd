extends Node

@onready var time_label = $"../CanvasLayer/TimeLabel"
@onready var date_label = $"../CanvasLayer/DateLabel"

var cycle_duration = 5 * 60.0
var current_time = 0.0
var current_day: int = 1
#gerçek hayatta 12.5 saniye oyunda 1 saat
var elapsed_thirst_time: float = 0.0 # Geçen su timerı
var elapsed_hunger_time: float = 0.0 # Geçen yemek timerı
var elapsed_sleep_time: float = 0.0 # Geçen uyku timerı

const THIRST_INTERVAL: float = 25.0 # 25 saniye 2 saat   10 saatte komple bitsin
const HUNGER_INTERVAL: float = 35.0 # 35 saniye 2.8 saat 14 saatte komple bitsin
const SLEEP_INTERVAL: float = 45.0 # 45 saniye 3.6 saat  18 saatte komple bitsin

@onready var stats_manager = $".."

func _ready() -> void:
	update_date_ui()

func _process(delta: float) -> void:
	set_day_cycle(delta)
	check_thirst_interval(delta)
	check_hunger_interval(delta)
	check_sleep_interval(delta)
	

func set_day_cycle(delta):
	current_time += (24.0 / cycle_duration) * delta
	if current_time >= 24.0:
		current_time -= 24.0
		current_day += 1
		update_date_ui()
	update_time_ui()

func check_thirst_interval(delta:float) -> void:
	elapsed_thirst_time += delta
	if elapsed_thirst_time >=THIRST_INTERVAL:
		stats_manager.set_thirst(-1)
		elapsed_thirst_time-=THIRST_INTERVAL
	

func check_hunger_interval(delta:float) -> void:
	elapsed_hunger_time += delta
	if elapsed_hunger_time >=HUNGER_INTERVAL:
		stats_manager.set_hunger(-1)
		elapsed_hunger_time-=HUNGER_INTERVAL
	

func check_sleep_interval(delta:float) -> void:
	elapsed_sleep_time += delta
	if elapsed_sleep_time >=SLEEP_INTERVAL:
		stats_manager.set_sleep(-1)
		elapsed_sleep_time-=SLEEP_INTERVAL
	

func update_time_ui():
	var hours = int(current_time)
	var minutes = int((current_time - hours) * 60)
	time_label.text = "%02d:%02d" % [hours, minutes]

func update_date_ui():
	date_label.text = "January " + str(current_day) + " 2025"
