extends Area2D


func broke():
	global.player_ores += 1
	
	queue_free()
