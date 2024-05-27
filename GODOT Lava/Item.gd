extends RigidBody2D

var orig_y
var target_y
var rng = RandomNumberGenerator.new()
var detected = false
var tween_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand_x = randf_range(200,-200)
	var rand_y = randf_range(-450,-500)
	apply_central_impulse(Vector2(rand_x, rand_y))
	orig_y = global_position.y
	target_y = orig_y + 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y < target_y + 5 and global_position.y > target_y + -5:
		freeze = true
		
	if PlayerVars.wave_intermission:
		detected = true
	
	if detected == true:
		var player = get_tree().current_scene.find_child('Player')
		var tween = create_tween()
		tween_time -= 0.075
		tween.tween_property($".",'position', player.position,tween_time)


func _on_area_2d_body_entered(body):
	detected = true
	print('sigma')


func _on_collector_body_entered(body):
	if body.name == 'Player':
		PlayerVars.Essence_stat += 1
		queue_free()
