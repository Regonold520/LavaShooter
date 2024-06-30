extends Area2D

var is_colliding = false
var is_toggled = false

var player

var rng = RandomNumberGenerator.new()

func _ready():
	for i in 3:
		var pool = Shop.pool["Weapons"][str(randi_range(1,3))]
		
		var slot = $Holder.find_child("Slot" + str(i + 1))
		var texture = load(pool["Texture"])
		
		slot.item_name = pool["Name"]
		slot.decription = pool["Decription"]
		slot.price = pool["Price"]
		slot.type = pool["Type"]
		slot.scene = load(pool["Item_Scene"])
		
		slot.get_child(1).texture = texture

func _process(delta):
	_player_interaction()
	
func _on_body_entered(body):
	is_colliding = true
	player = body

func _on_body_exited(body):
	is_colliding = false

func _player_interaction():
	if is_colliding and Input.is_action_just_pressed("Interact"):
		is_toggled = !is_toggled
		if player != null:
			player.lock_movement = !player.lock_movement
	
	if is_toggled:
		player.find_child("Sprite2D").animation = "Idle"
		
	$Holder.visible = is_toggled
