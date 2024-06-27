extends CharacterBody2D

var detected = false
var rand_vector : Vector2
var rng = RandomNumberGenerator.new()
var start_finished = false
var is_start

@export var speed = 50
var acceleration = 11
var direction

@onready var agent : NavigationAgent2D = $NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	
	var rand_pos_x = rng.randf_range(0,0)
	var rand_pos_y = rng.randf_range(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
	print(body)
	if body.name == "Player":
		_on_death()
		PlayerVars.Health -= 5


func _on_detection_body_exited(body):
	detected = false


func _on_body_entered(body):
	pass


func _essence():
	var essence = PlayerVars.Essence.instantiate()
	essence.global_position = global_position
	print(essence)
	get_tree().current_scene.add_child(essence)
	
func _on_death():
	var player = get_tree().current_scene.find_child('Player')
	player.find_child('EnemyDeath').play()
	
	queue_free()


func _on_timer_timeout():
	var player = get_tree().current_scene.find_child('Player')
	agent.target_position = player.global_position


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
