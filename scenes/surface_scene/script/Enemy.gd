extends Node2D

# Enum of state in wich the enemy can be
enum State {DEAD, MOVING, ATTACKING, NONE}

signal Enemy

onready var tree_spot = load("res://scenes/surface_scene/tree/tree_slot.tscn")

var target
var speed = 1
var buff = 0.5
var state = State.NONE
var HP = 100
#Level of the enemy
var lvl = 1
# Will be added to X value every time an enemy move put -1 if the enemy comes from right else +1
var direction = 1
var atckbool = true
var rand = randi()% 3 + 1

var target_type

signal attack_dmg(dmg)

func attack(t):
	target = t;
	target_type = t.type
	state = State.ATTACKING	
	$Animation.play("smash")
	$Buff.start()

func _physics_process(delta):
	if (position.x == 0):
		pass #LOSE
	if (state == State.MOVING):
		 position.x += direction * speed
	rand = randi()% 3 + 1
		
func _ready():
	state = State.NONE
	$Buff.wait_time = buff
	connect("attack_dmg", get_tree().root.get_node("Node3D/UI/lifebar"), "_attacked")

func launch():
	if position.x < 0:
		direction = 1
		$Sprite.flip_h = true
	else:
		direction = -1 		
	state = State.MOVING

func _on_Buff_timeout():
	if get_parent().get_node("WaveTimer").time_left >= buff:
		$Buff.start()
		if atckbool == true:
			var audio_path = load(str("res://assets/sound/axe"+ str(rand) +".ogg"))
			if target_type == 0:
				emit_signal("attack_dmg", 10 * lvl)
			else:
				if target.HP > 0:
					target.HP -= 10 * lvl
				else:
					atckbool = false
					state = State.MOVING
					target.queue_free()
					$Buff.stop()
					$Animation.play("Walk")
			$sound.stream = audio_path
			$sound.play()
		else:
			atckbool = true
