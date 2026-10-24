extends CharacterBody2D

var dir : Vector2
var speed := 150
var stamina :int = 200
var mining_process : int
signal break_ore

@onready var stamina_bar = $CanvasLayer/ProgressBar
@onready var ores_collectef = $CanvasLayer/collect/amount


func _physics_process(delta: float) -> void:
	dir = Input.get_vector("left","right","up","down").normalized()
	velocity = dir * speed
	move_and_slide()
	mining()
	stamina_bar.value = stamina
	ores_collectef.text = str("ores collectd :" , global.player_ores)

func mining():
	if Input.is_action_pressed("mineing") and stamina:
		if not stamina <= 0:
			stamina -= 1
		#print(stamina)
		print(mining_process)
		mining_process += 1
		if mining_process >= 100:
			mining_process = 0
			break_ore.emit()
		

func _on_interactable_zone_area_entered(area: Area2D) -> void:
	print(area)
	if area.has_method("broke"):
		break_ore.connect(area.broke)
	
