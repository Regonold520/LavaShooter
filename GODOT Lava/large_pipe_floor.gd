extends Node2D

var is_active = true
var enemy_pool = [Enemies.twins]
var wait_time = 2

@export var total_enemies = 2
var current_enemies = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().enemy_ammount += total_enemies
	
	$WaterSprite.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await get_tree().create_timer(wait_time).timeout
	
	$WaterSprite.play()
	
	if $WaterSprite.animation == "Grow" and $WaterSprite.frame == 4:
		$Timer.start()
		$Timer.autostart = true
		$WaterSprite.animation = "Idle"
		
	if $WaterSprite.animation == "Shrink" and $WaterSprite.frame == 4:
		$"WaterSprite".visible = false

	if is_active and $"WaterSprite".visible == false:
		$"WaterSprite".visible = true
		
	if !is_active and $"WaterSprite".visible == true:
		$"WaterSprite".animation = "Shrink"


func _on_timer_timeout():
	if is_active and current_enemies < total_enemies:
		var chosen = enemy_pool[rng.randi_range(0 , 0)]
		var enemy = chosen.instantiate()
		
		get_tree().current_scene.add_child(enemy)
		
		enemy.global_position = $EnemySpawns/Node2D.global_position
		
		current_enemies += 1
		
	if current_enemies == total_enemies and is_active:
		is_active = false
		print("incremented")
