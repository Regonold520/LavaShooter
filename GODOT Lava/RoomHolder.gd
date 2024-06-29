extends Node2D

var room_pool = ["res://Rooms/Room1.tscn" , "res://Rooms/Room2.tscn" , "res://Rooms/Room3.tscn" , "res://Rooms/Room4.tscn"]
var last_room = "res://Rooms/Room1.tscn"

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	_generate_room()

func _generate_room():
	if get_child_count() > 0:	
		get_child(0).queue_free()
	
	var chosen_room : PackedScene = load(room_pool[rng.randi_range(0 , room_pool.size() - 1)])
	
	var room = chosen_room.instantiate()
	
	add_child(room)
	
	var spawn_pos = room.find_child("Spawn")
	var player = get_tree().current_scene.find_child("Player")
	
	player.global_position = spawn_pos.global_position
