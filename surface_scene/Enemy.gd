extends Node2D

# Enum of state in wich the enemy can be
enum State {DEAD, MOVING, ATTACKING, NONE}

var target
var speed = 1
var buff = 2
var state = State.NONE
var HP = 100
#Level of the enemy
var lvl = 1
# Will be added to X value every time an enemy move put -1 if the enemy comes from right else +1
var direction = 1

func attack(t):
	target = t;
	state = State.ATTACKING
	$Buff.start()

func _physics_process(delta):
	if (position.x == 0):
		pass #LOSE
	if (state == State.MOVING):
		 position.x += direction * speed
		
func _ready():
	state = State.NONE
	$Buff.wait_time = buff
	
func launch():
	if position.x < 0:
		direction = 1
	else:
		direction = -1 		
	state = State.MOVING


func _on_Buff_timeout():
	if get_parent().get_node("WaveTimer").time_left >= buff:
		$Buff.start()
	target.get_node("HP").value -= 1
	pass # Replace with function body.
