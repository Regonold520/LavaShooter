extends CharacterBody2D

@export var speed := 250
var is_idle = false
var tween = Tween.new()

@onready var Pv = $"/root/PlayerVariables"

func _ready():
	pass

func _process(delta):
	
	var direction = Input.get_vector('Left','Right','Up','Down')
	velocity = direction * speed
	if direction.x > 0:
		$Sprite2D.scale.x = -0.184
	elif direction.x < 0:
		$Sprite2D.scale.x = 0.184
	move_and_slide()
	_gun_rotation()
	_update_stats()
	

	
func _update_stats():
	pass
	$"../Camera2D/MainUI/Health".text =  str(Pv.Health)
	$"../Camera2D/MainUI/Essence".text = str(Pv.EssenceStat)
	
func _gun_rotation():
	$GunPoint.look_at(get_global_mouse_position())
	$GunPoint.rotation_degrees += 90
	var flip_pos = $GunPoint.global_position - $GunPoint/Gun.global_position
	
	
	if flip_pos.x > 0:
		$GunPoint.scale.x = 1
	elif flip_pos.x == 0:
		$GunPoint.scale.x = 1
	elif flip_pos.x < 0:
		$GunPoint.scale.x = -1
		
		
func _update_anim():
	if velocity == Vector2(0, 0):
		$Sprite2D.animation = 'Idle'
	else:
		$Sprite2D.animation = 'Walk'


func _on_anim_change_timeout():
	_update_anim()
