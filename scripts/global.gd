extends Node

#game_state:	0 -> NoGame (pause, mort)
#				1 -> Exploration
#				2 -> Tower Defense
var game_state = 0

var coins = 10
var score = 0
var nickname = "salut"

var lvl = 1
# used to communicate between the root node and the
# tread speed up code wich by necesity happens elsewhere!
var root_default_speed = 50
var root_boosted_default_speed = 100
var root_speed = 50

var loose = false
