extends CharacterBody2D

@export var speed: float = 600.0
var animationState:String = "walk_down"
const Enums = preload("res://enums.gd")

func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	if $"..".gameState ==Enums.GameStates.PAUSED:
		$AnimatedSprite2D.stop()
		return
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
		$AnimatedSprite2D.flip_h=true
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
		$AnimatedSprite2D.flip_h=false
	if Input.is_action_pressed("move_down"):
		animationState="walk_down"
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		animationState="walk_up"
		input_vector.y -= 1
	if not Input.is_anything_pressed():
		$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play(animationState)
	input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()
	
