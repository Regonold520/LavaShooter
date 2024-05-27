extends Node

var screensize : Vector2
var rng = RandomNumberGenerator.new()

var Wave_1_enemies = [Enemies.drop]
var Wave_2_enemies = [Enemies.drop,Enemies.puddle]
var Wave_3_enemies = [Enemies.drop,Enemies.twins]
var Wave_4_enemies = [Enemies.drop,Enemies.puddle,Enemies.twins]
var Wave_5_enemies = [Enemies.drop,Enemies.puddle,Enemies.w_sentry]

var enemy : Node

var Wave = 1
var End_Wave = 6
var Wave_time = 100.0
var Total_enemies = 50.0
var Active_enemies : int
var intermission_time = 20.0

var Wave_time_a : PackedFloat64Array = [0,1,65,65,65,60]
var Total_enemies_a : PackedFloat64Array = [0,45,35,40,45,40]

var Enemies_s = 0

func _ready():
	_wave_start()

func _wave_start():
	PlayerVars.wave_intermission = false
	print('Wave ',Wave)
	Wave_time = Wave_time_a[Wave] 
	Total_enemies = Total_enemies_a[Wave]
	
	$WaveTime.wait_time = Wave_time_a[Wave]
	$WaveTime.start()
	
	Enemies_s = Wave_time / Total_enemies
	$SummonTimer.wait_time = Enemies_s
	
	$SummonTimer.start()
	Active_enemies = Total_enemies
	
func _process(delta):
	var screensize = get_viewport().size
	$"../Camera2D/MainUI/WaveText".text = 'Wave ' + str(Wave)
	$"../Camera2D/MainUI/WaveTime".text = str(round($WaveTime.time_left))


func _on_summon_timer_timeout():
	var summon = rng.randi_range(1,5)
	if summon > 0:
		_summon_enemy()
	
func _summon_enemy():
	Active_enemies -= 1
	var screensize = get_viewport().size
	
	if Wave == 1:
		Wave_1_enemies.shuffle()
		var chosen = Wave_1_enemies[0]
		enemy = chosen.instantiate()	
	elif Wave == 2:
		Wave_2_enemies.shuffle()
		var chosen = Wave_2_enemies[0]
		enemy = chosen.instantiate()
	elif Wave == 3:
		Wave_3_enemies.shuffle()
		var chosen = Wave_3_enemies[0]
		enemy = chosen.instantiate()
		
	elif Wave == 4:
		Wave_4_enemies.shuffle()
		var chosen = Wave_4_enemies[0]
		enemy = chosen.instantiate()
	elif Wave == 5:
		Wave_5_enemies.shuffle()
		var chosen = Wave_5_enemies[0]
		enemy = chosen.instantiate()
	
	var assignment = rng.randi_range(1,4) #
	$"../.".add_child(enemy)
	var tween = create_tween()


func _on_wave_time_timeout():
	$WaveTime.stop()
	$SummonTimer.stop()
	
	var end_enemies = get_tree().get_nodes_in_group('enemy')
	
	for enemy in end_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
			
	_start_intermission()
	

func _start_intermission():
	PlayerVars.wave_intermission = true
	$IntermissionTimer.start()


func _on_intermission_timer_timeout():
	if Wave + 1 != End_Wave:
		Wave += 1
		_wave_start()
	else:
		pass
