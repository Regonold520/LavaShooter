extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var start_finished = false

@export var finish_frame = 0

@export var speed = 75
var acceleration = 11
var direction

@onready var agent : NavigationAgent2D = $NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "Rise"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.animation == "Rise" and $AnimatedSprite2D.frame == finish_frame:
		$AnimatedSprite2D.animation = "Idle"
		start_finished = true
	
	if !start_finished:
		$Detection/CollisionShape2D.disabled = true
	if start_finished:
		$Detection/CollisionShape2D.disabled = false
	
	if start_finished:
	
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)
			
		direction = agent.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = velocity.lerp(direction * speed, acceleration * delta)
		
		if agent.avoidance_enabled:
			agent.set_velocity(velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(velocity)
		
		move_and_slide()
	


func _update_anim(player):
	if player.position > position:
		$AnimatedSprite2D.scale.x = -0.184
	if player.position < position:
		$AnimatedSprite2D.scale.x = 0.184
	

func _on_detection_body_entered(body):
	if body.name == "Player":
		_on_death()
		PlayerVars.Health -= 5
	
func _essence():
	var essence = PlayerVars.Essence.instantiate()
	essence.position = position
	get_tree().current_scene.add_child(essence)
		
func _on_death():
	var audio = Enemies.enemy_audio.instantiate()
	get_tree().current_scene.add_child(audio)
	
	var player = get_tree().current_scene.find_child('Player')
	player.find_child('EnemyDeath').play()
	
	get_parent().find_child("RoomHolder").get_child(0).completed_enemies += 1
	
	queue_free()
	


func _on_timer_timeout():
	var player = get_tree().current_scene.find_child('Player')
	agent.target_position = player.global_position


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
